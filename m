Message-ID: <390E55F1.CD5D0605@mac.com>
Date: Tue, 02 May 2000 00:13:37 -0400
From: Andrew Thompson <lordpixel@mac.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 5 button mouse and XFree86 vers 4
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Posted something similar to this on the users list a few days ago and no
one seemed to know, so I'm hoping someone here does...

Well last night I took the plunge and switched to XFree86 vers 4, using the
rpms from here:
http://entropy.crashing.org/~howarth/

What I'm trying to do now is get all 5 buttons working on my Kensington
Mouseworks USB mouse.

I tried adding this lines to my XF86Config
        Option      "Buttons" "5"

But no dice. Has anytone had any luck with > 3 buttons so far?

A little further info:

xmodmap -pp reports 5 buttons are defined, but if I redefine the mapping I
just lose buttons and buttons 2 and 4 don't seen to be generating any
events in X.

If I use "xev" and click in the window, nothing is reported for buttons 2
and 4. Button 1 is reported as 1, button 3 as 2 and button 5 as 3.

So I did some reading in the XFree86 docs and discovered that the PS/2
protocol only supports 3 buttons. PS/2 mice with > 3 buttons need some
vendor specific initialisation. The protocol for the old Kensington
Thinking mouse PS/2 version doesn't work with this new Kensignton
Mouseworks (I tried it).

This would imply that what I want to do is use the mouse as a generic HID 5
button USB mouse. But when I try to use the usb (or USB) protocol with the
above RPM of XFree86 vers 4 it complains that usb is an unkown protocol!

Can someone enlighten me as to the story with USB mice on linux ppc? Are we
somehow shimying them so they appear as PS/2 or ADB?
Why isn't USB support on in the above RPMs? If I get the source RPM and
build it myself can I turn in on maybe?

AndyT

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
