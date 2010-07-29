function handle_soe_drop(draggable_element, droppable_element) {
    if (Element.firstDescendant(droppable_element) != null)
      Element.remove (Element.firstDescendant(droppable_element));
    Element.insert(droppable_element, '<img src=\"' + Element.readAttribute(draggable_element, 'src') + '\">');
    draggable_element.hide();
    position = droppable_element.id[4]
    Element.writeAttribute('proposition_position' + position, 'value', draggable_element.id);
}

function clear_current() {
  Field.setValue('proposition_positionA', '' );
  Field.setValue('proposition_positionB', '' );  
  Field.setValue( 'proposition_amount', Element.readAttribute( 'proposition_amount', 'data_initial_amount' ) );
  Field.disable('pass_button');
  Field.enable('submit_button');
  $$('.token').each(function (name, index) {
    $(name).show();
  });
  Element.update ('propA', '');
  Element.update ('propB', '');
  
}
