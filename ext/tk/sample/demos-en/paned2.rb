# paned2.rb --
#
# This demonstration script creates a toplevel window containing
# a paned window that separates two windows vertically.
#
# based on "Id: paned2.tcl,v 1.1 2002/02/22 14:07:01 dkf Exp"

if defined?($paned2_demo) && $paned2_demo
  $paned2_demo.destroy 
  $paned2_demo = nil
end

$paned2_demo = TkToplevel.new {|w|
  title("Vertical Paned Window Demonstration")
  iconname("paned2")
  positionWindow(w)
}

TkLabel.new($paned2_demo, 
	    :font=>$font, :wraplength=>'4i', :justify=>:left, 
	    :text=><<EOL).pack(:side=>:top)
The sash between the two scrolled windows below can be used to divide the area between them.  Use the left mouse button to resize without redrawing by just moving the sash, and use the middle mouse button to resize opaquely (always redrawing the windows in each position.)
If your Tk library linked to Ruby doesn't include a 'panedwindow', this demo doesn't work. Please use later version of Tk which supports a 'panedwindow'.
EOL

# The bottom buttons
TkFrame.new($paned2_demo){|f|
  pack(:side=>:bottom, :fill=>:x, :pady=>'2m')

  TkButton.new(f, :text=>'Dismiss', :width=>15, :command=>proc{
		 $paned2_demo.destroy
		 $paned2_demo = nil
	       }).pack(:side=>:left, :expand=>true)

  TkButton.new(f, :text=>'See Code', :width=>15, :command=>proc{
		 showCode 'paned2'
	       }).pack(:side=>:left, :expand=>true)
}

paneList = TkVariable.new  # define as normal variable (not array)
paneList.value = [         # ruby's array --> tcl's list
    'List of Ruby/Tk Widgets',
    'TkButton', 
    'TkCanvas', 
    'TkCheckbutton', 
    'TkEntry', 
    'TkFrame', 
    'TkLabel', 
    'TkLabelframe', 
    'TkListbox', 
    'TkMenu', 
    'TkMenubutton', 
    'TkMessage', 
    'TkPanedwindow', 
    'TkRadiobutton', 
    'TkScale', 
    'TkScrollbar', 
    'TkSpinbox', 
    'TkText', 
    'TkToplevel'
]

# Create the pane itself
TkPanedwindow.new($paned2_demo, :orient=>:vertical){|f|
  pack(:side=>:top, :expand=>true, :fill=>:both, :pady=>2, :padx=>'2m')

  add(TkFrame.new(f){|paned2_top|
	TkListbox.new(paned2_top, :listvariable=>paneList) {
	  # Invert the first item to highlight it
	  itemconfigure(0, :background=>self.cget(:foreground), 
			   :foreground=>self.cget(:background) )
	  yscrollbar(TkScrollbar.new(paned2_top).pack(:side=>:right, 
						      :fill=>:y))
	  pack(:fill=>:both, :expand=>true)
	}
      }, 

      TkFrame.new(f, :height=>120) {|paned2_bottom|
	# The bottom window is a text widget with scrollbar
	paned2_xscr = TkScrollbar.new(paned2_bottom)
	paned2_yscr = TkScrollbar.new(paned2_bottom)
	paned2_text = TkText.new(paned2_bottom, :width=>30, :wrap=>:non) {
	  insert('1.0', "This is just a normal text widget")
	  xscrollbar(paned2_xscr)
	  yscrollbar(paned2_yscr)
	}
	Tk.grid(paned2_text, paned2_yscr, :sticky=>'nsew')
	Tk.grid(paned2_xscr, :sticky=>'nsew')
	TkGrid.columnconfigure(paned2_bottom, 0, :weight=>1)
	TkGrid.rowconfigure(paned2_bottom, 0, :weight=>1)
      } )
}
