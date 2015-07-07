# ImageGroup
class ImageGroup
  include SAXMachine

  element :IMAGEFILE
  element :IMAGE_PRESENT
  element :IMAGE_COLOUR
  element :IMG_TECH_SPEC
  element :IMAGE_SIZE
  element :CAPTION
  element :IMAGE_EXTENT

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.join('|')
  end
end
