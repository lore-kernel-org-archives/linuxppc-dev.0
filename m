Mime-Version: 1.0
Message-Id: <v04205501b3b3f4be6576@[195.227.39.191]>
Date: Thu, 15 Jul 1999 22:34:36 +0200
To: linuxppc-dev@lists.linuxppc.org
From: "Dr. Matthias Dräger"  <matthias.draeger@telelev.net>
Subject: LPPC1999, 7500, USB Mouse & ADB Keyboard - Config, XPMac VRAM
 problem
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry if this is not the right list, but I found nothing about this 
an the LPPC support is quite clueless about this one and pointed me 
here...

#-------
I have a Keyspan USB card installed in Pmac 7500 and a three-button 
Logitech USB mouse attached to the card. I try to install a virgin 
LPPC 1999 via BootX.

#-------
When I install LinuxPPC with only an ADB mouse, this one is 
recognized, also the keyboard works quite nicely, albeit with an US, 
not german layout.


With onyl the USB mouse no other ADB pointing device attached it 
correctly identifies the USB mouse and all three button work without 
a flaw.


So far so good. Problem: in /etc/sysconfig/keyboard also an USB 
keyboard and keytable is configured (probably the installer thinks it 
is installing on an iMac), and typing I get nothing.

If I change /etc/.../keyboard to KB type "adb" and layout "us", the 
keyboard is recognized, but i only get garbage. At  boot time loading 
the default keymap succeedes, though

Using layout "asjkhd" (any garbage will do), the keyboard layout is 
almost OK, but the delete and backspace keys do not work in the login 
screen or any Gnome / KDE app, but in XTerm. At  boot time loading 
the default keymap fails (for good reason).
#----------
*Question: How do I need to configure the keyboard and mouse to use the
  three button USB mouse and my ABD Apple extended keyboard with the correct
  (preferrably german) layout?
#-----------


*------------
XPmac also does not recognize more than 2MB of VRAM on my CONTROL 
display adapter yielding only the 1552x...@16bpp resolution at max.
*------------
*Question: How do I get use of my whole 4MB VRAM?
*------------
For Your help many thanks in advance

Cheers

Matthias Draeger
------------------------------------------------------------------------
Dr. Matthias Draeger       Mail: mailto:matthias.draeger@telelev.net
Am alten Schafstall 3-5          mailto:matthias.draeger.md@bayer-ag.de
                            Fon:  +49 (0)214 6 75 04
51373 Leverkusen, FRG      D2:   +49 (0)172 29 89 945
------------------------------------------------------------------------
Australia Photo Gallery:         http://www.thch.uni-bonn.de/Oz-Gallery
DeAN Homepage:                   http://pcgate.thch.uni-bonn.de/DeAN
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
