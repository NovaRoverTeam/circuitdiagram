class Connector {
  final int TEXT_SIZE = 20;
  final float LABEL_X_OFFSET = 10.0;
  final float LABEL_Y_OFFSET = 20.0;
  
  Node parent_node1, parent_node2;
  int my_id, position1, position2, num_of_lines;
  float node1_x, node1_y, node2_x, node2_y, x_midpoint, y_midpoint;
  color line_colour = color(100, 100, 100, 255);
  boolean is_visible = true;
  String connector_label;
  int label_position;

  Connector(int id, Node node1, Node node2, int node1_exit_position, int node2_enter_position, int colour, String label, int label_side, int num_lines) {
    parent_node1 = node1;
    parent_node2 = node2;
    position1 = node1_exit_position;
    position2 = node2_enter_position;
    num_of_lines = num_lines;
    my_id = id;
    connector_label = label;
    label_position = label_side;
    node1.connector_id_array[node1.num_of_connectors] = my_id;
    node1.num_of_connectors++;
    node2.connector_id_array[node2.num_of_connectors] = my_id;
    node2.num_of_connectors++;
    
    
    switch(node1_exit_position) {
      case 0:
        node1_x = parent_node1.x_coord;
        node1_y = parent_node1.y_coord-(NODE_HEIGHT/2); 
        break;
      case 1:
        node1_x = parent_node1.x_coord+(NODE_WIDTH/2);
        node1_y = parent_node1.y_coord;
        break;
      case 2:
        node1_x = parent_node1.x_coord;
        node1_y = parent_node1.y_coord+(NODE_HEIGHT/2);
        break;
    }
    
    switch(node2_enter_position) {
      case 0:
        node2_x = parent_node2.x_coord;
        node2_y = parent_node2.y_coord-(NODE_HEIGHT/2);
        break;
      case 2:
        node2_x = parent_node2.x_coord;
        node2_y = parent_node2.y_coord+(NODE_HEIGHT/2);
        break;
      case 3:
        node2_x = parent_node2.x_coord-(NODE_WIDTH/2);
        node2_y = parent_node2.y_coord;
        break;
    }
    
    switch(colour) {
      case 0:
        line_colour = color(100, 100, 100, 255);
        break;
      case 1:
        line_colour = color(255, 87, 87, 255);
        break;
      case 2:
        line_colour = color(255, 133, 51, 255);
    }
  }

  void UpdatePosition(float delta_x, float delta_y) {
    node1_x += delta_x;
    node1_y += delta_y;
    node2_x += delta_x;
    node2_y += delta_y;
  }

  void SetTransparency(int alpha) {
    
    line_colour = color(100, 100, 100, alpha);
  
  }
  
  void Display() {
    if(is_visible) {
      stroke(line_colour);
      strokeWeight(CONNECTOR_THICKNESS);
      textSize(TEXT_SIZE);
      fill(line_colour);
      
      x_midpoint = node1_x+((node2_x-node1_x)/2);
      y_midpoint = node1_y+((node2_y-node1_y)/2);
      
      switch(num_of_lines) {
        case 1:
          if(node1_y==node2_y) {
            textAlign(CENTER, CENTER);
            if(label_position == 0) {
              text(connector_label, x_midpoint, node1_y - LABEL_Y_OFFSET);
            }
            else {
              text(connector_label, x_midpoint, node1_y + LABEL_Y_OFFSET);
            }
          }
          else {
            if(label_position == 0) {
              textAlign(RIGHT, CENTER);
              text(connector_label, x_midpoint - LABEL_X_OFFSET, y_midpoint);
            }
            else {
              textAlign(LEFT, CENTER);
              text(connector_label, x_midpoint + LABEL_X_OFFSET, y_midpoint);
            }            
          }
          
          line(node1_x, node1_y, node2_x, node2_y);
          break;
        case 2:
          textAlign(CENTER, CENTER);
          if(position1 == 1 || position1 == 3) {
            line(node1_x, node1_y, node2_x, node1_y);
            line(node2_x, node1_y, node2_x, node2_y);
            if(label_position == 0) {
              text(connector_label, x_midpoint, node1_y - LABEL_Y_OFFSET);
            }
            else {
              text(connector_label, x_midpoint, node1_y + LABEL_Y_OFFSET);
            }
          }
          else {
            line(node1_x, node1_y, node1_x, node2_y);
            line(node1_x, node2_y, node2_x, node2_y);  
            if(label_position == 0) {
              text(connector_label, x_midpoint, node2_y - LABEL_Y_OFFSET);
            }
            else {
              text(connector_label, x_midpoint, node2_y + LABEL_Y_OFFSET);
            }
          }
          break;
        case 3 :
          line(node1_x, node1_y, x_midpoint, node1_y);
          line(x_midpoint, node1_y, x_midpoint, node2_y);
          line(x_midpoint, node2_y, node2_x, node2_y);  
          if(label_position == 0) {
            textAlign(RIGHT, CENTER);
            text(connector_label, x_midpoint - LABEL_X_OFFSET, y_midpoint);
          }
          else {
            textAlign(LEFT, CENTER);
            text(connector_label, x_midpoint + LABEL_X_OFFSET, y_midpoint);
          }
          break;
      }
    }
  }
}