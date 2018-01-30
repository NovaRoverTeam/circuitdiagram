class Node {
  final int TEXT_SIZE = 26;
  final float TEXTBOX_INSET = 10;
  
  float img_x, img_y;
  float x_coord, y_coord, rect_width, rect_height;
  float kicad_icon_x = (width/2) + (EXPANDED_SIZE_INCREASE/2) - 35;
  float kicad_icon_y = (height/2) + (EXPANDED_SIZE_INCREASE/2) - 105;
  
  float chrome_icon_x = (width/2) + (EXPANDED_SIZE_INCREASE/2) - 65;
  float chrome_icon_y = (height/2) + (EXPANDED_SIZE_INCREASE/2) - 105;
  
  Connector[] node_connections;
  int num_of_connectors = 0;
  int[] connector_id_array = {-1,-1,-1,-1,-1};
  
  String[] links = {"", "", "", "", ""};
  int num_of_links = 0;
  
  int alpha = 255;
  int my_id;
  String node_name;
  color border_colour = color(100, 100, 100, alpha);
  boolean mouse_is_over = false;
  boolean node_activated = false;
  boolean block_at_centre = false;
  boolean expand_node = false;
  boolean reduce_node = false;
  boolean display_image = false;
  boolean node_expanded = false;
  boolean mouse_over_kicad = false;
  boolean mouse_over_chrome = false;
  

  Node(int id, float x, float y, float w, float h, String name) {
    my_id = id;
    x_coord = x;
    y_coord = y;
    rect_width = w;
    rect_height = h;
    node_name = name;
    
  }

  void AddLink(String link) {
    links[num_of_links] = link;
    num_of_links++;
  }
  
  void OpenLinks() {
    for(int i = 0; i < num_of_links; i++) {
      link(links[i]);
    }
  }

  boolean MouseIsInside() {
    if ((mouseX > (x_coord-(rect_width/2))) && (mouseX < (x_coord+(rect_width/2)))
        && (mouseY > (y_coord-(rect_height/2))) && (mouseY < (y_coord+(rect_height/2)))) {
          return true;
    }
    else {
      return false;
    }
  }
  
  boolean MouseIsOverIcon(float icon_x, float icon_y) {
    if((mouseX > (icon_x) && (mouseX < (icon_x+25))
        && (mouseY > (icon_y) && (mouseY < (icon_y+25))))) {
          return true;
        }
        else {
          return false;
        }
  }

  void CheckRollover() {
    if(global_lock_disabled) {
      if (MouseIsInside()) {
        border_colour = color(50, 50, 50, alpha);
        mouse_is_over = true;
      }
      else {
        border_colour = color(100, 100, 100, alpha);
        mouse_is_over = false;
      }
    }
    else {
      mouse_over_kicad = MouseIsOverIcon(kicad_icon_x, kicad_icon_y);
      mouse_over_chrome = MouseIsOverIcon(chrome_icon_x, chrome_icon_y);
    }
  }
  
  void UpdatePosition(float delta_x, float delta_y) {
    x_coord += delta_x;
    y_coord += delta_y;
  }
  
  void SetTransparency(int value) {
    alpha = value;
    border_colour = color(100, 100, 100, alpha);
  }

  void Display() {
    if(node_activated && !block_at_centre) {
      float x_diff, y_diff;
      
      float x_modifier = 1.0;
      float y_modifier = 1.0;
      int axis_in_position = 0;
      
      x_diff = (width/2) - x_coord;
      if(x_diff < 0)
      {
        x_modifier = -1.0;
      }
      
      y_diff = (height/2) - y_coord;
      if(y_diff < 0)
      {
        y_modifier = -1.0;
      }
      
      if((abs(x_diff) - EXPAND_MOVE_STEP)>=0) {
        x_diff = x_modifier * EXPAND_MOVE_STEP;
      }
      else {
        axis_in_position++;
      }
      
      if((abs(y_diff) - EXPAND_MOVE_STEP)>=0) {
        y_diff = y_modifier * EXPAND_MOVE_STEP;
      }
      else {
        axis_in_position++;
      }
      
      UpdatePositions(x_diff, y_diff);
      
      if(axis_in_position == 2) {
        block_at_centre = true;
        expand_node = true;
      }
    }
    else if(block_at_centre && expand_node) {
        if(rect_width < EXPANDED_SIZE_INCREASE) {
          rect_width += EXPAND_WIDTH_STEP;
          rect_height += EXPAND_HEIGHT_STEP;
        }
        else {
          expand_node = false;
          node_expanded = true;
        }
    }
    else if(block_at_centre && reduce_node) {
        if(rect_width > NODE_WIDTH) {
          rect_width -= EXPAND_WIDTH_STEP;
          rect_height -= EXPAND_HEIGHT_STEP;
        }
        else {
          reduce_node = false;
          node_activated = false;
          global_lock_disabled = true;
          block_at_centre = false;
          for (int i = 0; i < connector_id_array.length; i++) {
            if(connector_id_array[i] == -1)
            {
              break;
            }
            else {
              connectors[connector_id_array[i]].is_visible = true;
            }
          }
        }
    }
    rectMode(CENTER);
    if(node_activated && block_at_centre) {
      strokeWeight(8);
      fill(255, 255, 255, 232);
    }
    else {
      strokeWeight(NODE_BORDER_THICKNESS);
      fill(255, 255, 255, 0);

    }
    stroke(border_colour);
    rect(x_coord, y_coord, rect_width, rect_height);
    if(!node_activated) {
      textAlign(CENTER, CENTER);
      textSize(TEXT_SIZE);
      fill(border_colour);

      text(node_name, x_coord, y_coord, (rect_width - TEXTBOX_INSET), (rect_width - TEXTBOX_INSET));
    }
    else {
      if(node_expanded) {
        imageMode(CORNER);
        if(mouse_over_kicad) {
          image(kicad_img, kicad_icon_x, kicad_icon_y);
        }
        else {
          image(kicad_img_gray, kicad_icon_x, kicad_icon_y);
        }
        if(mouse_over_chrome) {
          image(chrome_img, chrome_icon_x, chrome_icon_y);
        }
        else {
          image(chrome_img_gray, chrome_icon_x, chrome_icon_y);
        }
      }
    }
    if(display_image) {
      imageMode(CENTER);
      image(encoder_img, width/2, height/2, width, height);
    }
  }
}