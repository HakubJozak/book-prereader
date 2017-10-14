module ApplicationHelper
  def analyze_button(f)
    f.submit class: 'btn btn-primary btn-lg', value: 'Analyze Vocabulary'    
  end
end
