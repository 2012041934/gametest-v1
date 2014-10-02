public class Main : SEScene
{
    SESprite fg;
    SESprite bg;
     bool move_right=true;
    bool move_left=false;
    bool move_down = true;
    bool move_up = false;
    int speed=100;
    double rotation = 0;
    int bounce=0;
    String my_text;
    SESprite text;
  
    public void initialize(SEResourceCache rsc) {
        base.initialize(rsc);
        my_text = "BOUNCE = %d".printf().add(Primitive.for_integer(bounce)).to_string();
        bg = add_sprite_for_color(Color.instance("black"),get_scene_width(),get_scene_height());
        bg.move(0,0);
        //fg = add_sprite_for_color(Color.instance("green"),get_scene_width()*0.1,get_scene_height()*0.1);
        rsc.prepare_image("index","index",get_scene_width()*0.1, get_scene_height()*0.1);
		fg=add_sprite_for_image(SEImage.for_resource("index"));
		 fg.move(0,0);
       
		 rsc.prepare_font("myfont","arial bold color=white",40);
        text = add_sprite_for_text(my_text,"myfont");
        text.move(0,get_scene_height()-text.get_height()-100);
    }

    public void update(TimeVal now, double delta) {
        base.update(now,delta);
        rotation+=MathConstant.M_PI_4/4;
        fg.set_rotation(rotation);
        if(move_right) {
            if(fg.get_x()+fg.get_width()>=get_scene_width()) {
                fg.move(get_scene_width()-fg.get_width(),fg.get_y());
                move_left = true;
                move_right = false;
                speed = 100;
                bounce++;
            }
            else {
                fg.move(fg.get_x()+delta*speed,fg.get_y());
            }
        }
      
        else if(move_left) {
            if(fg.get_x()<=0) {
                 fg.move(0,fg.get_y());
                 move_left = false;
                 move_right = true;
                 speed = 100;
                 bounce++;
            }
            else {
                fg.move(fg.get_x()-delta*speed,fg.get_y());
            }

        }


        if(move_down) {
            if(fg.get_y()+fg.get_height()>=get_scene_height()) {
                fg.move(fg.get_x(),get_scene_height()-fg.get_height());
                move_up = true;
                move_down = false;
                speed = 100;
                bounce++;
            }
            else {
                fg.move(fg.get_x(),fg.get_y()+delta*speed);
            }
        }
      
        else if(move_up) {
            if(fg.get_y()<=0) {
                 fg.move(fg.get_x(),0);
                 move_up = false;
                 move_down = true;
                 speed = 100;
                 bounce++;
            }
            else {
                fg.move(fg.get_x(),fg.get_y()-delta*speed);
            }
        }
    my_text = "BOUNCING RECTANGLE= %d".printf().add(Primitive.for_integer(bounce)).to_string();
    text.set_text(my_text,"myfont");
    speed = speed * 1.2;
    }
    public void set_rotation(double angle) {
                rotation = angle;
              
    }
    public double get_rotation() {
                return(rotation);
              
    }
    public void cleanup() {
    base.cleanup();
    SESprite.remove(fg);
    SESprite.remove(bg);
    SESprite.remove(text);
    }

}
