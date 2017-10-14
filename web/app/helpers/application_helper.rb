module ApplicationHelper
  def analyze_button(f)
    f.submit class: 'btn btn-primary btn-lg', value: 'Analyze Vocabulary'    
  end

  def word_popover(w)
    content_tag :pre do
      w.definition
    end
  end

  def word_class(w)
    if w.known?
      'success'
    elsif w.known == false
      'danger'
    elsif w.known?.nil?
      'muted'
    end
  end
end
