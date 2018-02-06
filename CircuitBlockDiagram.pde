final int NUM_OF_NODES = 10;
final int NODE_WIDTH = 180;
final int NODE_HEIGHT = 150;
final int NODE_BORDER_THICKNESS = 5;

final int NUM_OF_CONNECTORS = 12;
final int CONNECTOR_THICKNESS = 5;

final float EXPAND_MOVE_STEP = 20.0; 
final int EXPAND_WIDTH_STEP = 20;
final int EXPAND_HEIGHT_STEP = 15;
final int EXPANDED_SIZE_INCREASE = 600;

boolean global_lock_disabled = true;
int activated_node = -1;

PImage encoder_img, kicad_img, kicad_img_gray, chrome_img, chrome_img_gray;

Node[] nodes; 
Connector[] connectors;

void setup() {
  size(1280, 720);
  frameRate(60);
  smooth(4);
  background(255);
  kicad_img = loadImage("icons/kicad_icon.png");
  chrome_img = loadImage("icons/chrome_icon.png");
  kicad_img.resize(0,25);
  chrome_img.resize(0,27);
  kicad_img_gray = loadImage("icons/kicad_icon.png");
  kicad_img_gray.resize(0,25);
  kicad_img_gray.filter(GRAY);
  chrome_img_gray = loadImage("icons/chrome_icon.png");
  chrome_img_gray.resize(0,27);
  chrome_img_gray.filter(GRAY);
  nodes = new Node[NUM_OF_NODES];
  connectors = new Connector[NUM_OF_CONNECTORS];
  CreateNodes();
  CreateConnectors();
}

void draw() {
  background(255);
  UpdateNodes();
  DisplayConnectors();
  DisplayNodes();
}

void UpdateNodes() {
  for (int i=0; i<NUM_OF_NODES; i++) {
    nodes[i].CheckRollover();
  }
}

void DisplayNodes() {
  int expanded_node_id = -1;
  for (int i=0; i<NUM_OF_NODES; i++) {
    if(nodes[i].node_activated) {
      expanded_node_id = i;
    }
    else { 
      nodes[i].Display();
    }
  }
  if(expanded_node_id != -1) {
    nodes[expanded_node_id].Display();
  }
}

void UpdatePositions(float delta_x, float delta_y) {
    for (int i = 0; i < NUM_OF_NODES; i++) {
      nodes[i].UpdatePosition(delta_x, delta_y);
    }
    for (int i = 0; i < NUM_OF_CONNECTORS; i++) {
      connectors[i].UpdatePosition(delta_x, delta_y);
    }
}

void DisplayConnectors() {
  for (int i=0; i<NUM_OF_CONNECTORS; i++) {
    connectors[i].Display();
  }
}

void mouseDragged() {
  float x_diff = mouseX-pmouseX;
  float y_diff = mouseY-pmouseY;
  if(global_lock_disabled) { 
    UpdatePositions(x_diff, y_diff);
  }
  else if(nodes[activated_node].display_image == true) {
    nodes[activated_node].UpdateImagePosition(x_diff, y_diff);
  }
}

void mousePressed() {
  if(global_lock_disabled) {
    for (int i = 0; i < NUM_OF_NODES; i++) {
      if(nodes[i].mouse_is_over)
      {
        activated_node = i;
        nodes[i].node_activated = true;
        global_lock_disabled = false;
        for (int j = 0; j < nodes[activated_node].connector_id_array.length; j++) {
          if(nodes[activated_node].connector_id_array[j] == -1)
          {
            break;
          }
          else {
            connectors[nodes[activated_node].connector_id_array[j]].is_visible = false;
          }
        }
        break;
      }
    }
  }
  else {
    if (!nodes[activated_node].MouseIsInsideNode() && !nodes[activated_node].display_image) {
      nodes[activated_node].node_expanded = false;
      nodes[activated_node].reduce_node = true;
    }
    else {
      if(nodes[activated_node].display_image) {
        if(nodes[activated_node].mouse_over_arrow) {
          nodes[activated_node].display_image = false;
        }
      }
      else if(nodes[activated_node].mouse_over_kicad && nodes[activated_node].kicad_enabled) {
        nodes[activated_node].display_image = true;
      }
      else if(nodes[activated_node].mouse_over_chrome) {
        nodes[activated_node].OpenLinks();
      }
    }
  }
}