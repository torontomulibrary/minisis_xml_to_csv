# ControllingGroup
class ControllingGroup
  include SAXMachine

  element :DATE_CONTROLLED
  element :CONT_AGENCY # UNMAPPED

  def to_s
    self.send :DATE_CONTROLLED
  end
end
