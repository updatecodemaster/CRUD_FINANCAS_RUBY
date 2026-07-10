class RelativeViewResolver < ActionView::FileSystemResolver
  def initialize(path)
    super(path)
    @path = path.to_s.tr("\\", "/").delete_suffix("/")
  end

  private

  # O FileSystemResolver padrão expande o caminho absoluto. Em diretórios com
  # acento no Windows, esse caminho pode quebrar o glob de templates.
  def template_glob(glob)
    query = File.join(escape_entry(@path), glob)
    path_with_slash = File.join(@path, "")

    Dir.glob(query).filter_map do |filename|
      filename = filename.tr("\\", "/")
      next if File.directory?(filename)
      next unless filename.start_with?(path_with_slash)

      filename
    end
  end
end
