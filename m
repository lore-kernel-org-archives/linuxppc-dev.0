Date: Sat, 15 May 1999 18:23:37 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Frame buffer weirdness?
Message-ID: <Pine.LNX.3.96.990515174202.20309D-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, I've been noticing this problem ever since I moved to linuxppc-pre-R5. 
They are two different problems, I believe, that are related to how text
is viewed on the screen. My system is a UMAX S900 with a 4MB ixMicro Twin
Turbo card.

1. In The Console

Sometimes when I boot into LinuxPPC pre R5 from BootX 1.02 at startup, I
get white text on a black background (so what you say!) but in the rest of
the empty space (at the end of lines, empty lines, etc.) I get green and
black vertical lines. In addition to that, whenever I switch between
virtual consoles (via Alt-F2, etc.) I get a different background color,
but text is always displayed as white on black. For instance, virtual
console #2 might have green while virtual console #5 might have cyan. This
is mostly just an eyesore, but when I get the vertical bands in the
console, I am guaranteed to have the problems described in the next
section. This doesn't usually happen if I boot into the MacOS and then
launch into LinuxPPC using BootX from the Finder. 

2. In X

This is more frustrating since it can make X unuseable. I'm currently
running XFree86-3.3.3.1-49a and Gnome 1.01 (not sure - different parts
have different versions). In 16 and 32 bit modes, text in menus, buttons
and xterms seem to be black on black. Totally unreadable. In 8 bit mode,
it is sometimes unreadable with black text on a striped background (green
and black or red and black vertical bands.)

But this doesn't happen with all text. For instance, I can read the titles
of windows without a problem, I can read the words G.N.O.M.E and "HELP
INDEX" in the toc of the Gnome Help Browser, but all of the links at the
bottom of the page are obscured with vertical bands. The same thing
happens with text typed into the gnome terminal, but I can clean this up a
bit by mini/maximizing the window or calling xrefresh. Nxterms look
cleaner with text displayed, but empty space is filled with vertical bands
(sometimes!) 

Sometimes everything in 8 bit mode is fine. No color bands or obscured
text. I'm having absolutely no luck trying to find a pattern for the
creation of these screen artifacts. 

I have noticed that certain versions of XFree/Gnome from linuxppc-pre-R5
in the past did not display these problems (some even worked in 16 and 32
bits,) but I have erased them with each update of ftp.linuxppc.org, so I
can't go back to them.

So any ideas on either of these problems? I haven't checked out dev rel
1.0 yet. Is it any different/better?

Kevin Hendrickson
*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
