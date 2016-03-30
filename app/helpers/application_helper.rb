module ApplicationHelper
  def full_title page_title = ""
    base_title = t "my_app.name"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_fields name, f, association, option_type
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render association.to_s.singularize + "_" + option_type + "_fields", f: builder
    end
    link_to name, "", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
  end

  def custom_select f, method, association, choices = nil, selected
    options_for_select = choices.map do |key, option_type|
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render association.to_s.singularize + "_" + option_type + "_fields", f: builder
      end
      unless option_type.eql? "text"
        add_btn = link_to_add_fields t("add_option"), f, :question_options, option_type
        fields += add_btn
      end      
      [ option_type, option_type, {data: {id: id, fields: fields.gsub("\n", "")}} ] 
    end

    f.select method, options_for_select, {selected: selected}, {class: "option_type"}
  end  
end
