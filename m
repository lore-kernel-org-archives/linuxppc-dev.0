Date: Sun, 27 Jun 1999 01:36:07 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: HELP - I'm going mad: mp3/adb conflict; r5/mouse button emu; twm/menu
Message-ID: <Pine.GSO.4.05.9906270129400.10109-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got a few problems with my new r5 system, the first of which is
absolutely driving me nuts.

PowerCenter Pro 210 / 96MB RAM.

1) Say I'm playing an mp3 with either xmms or mpg123.  If I move a
window around w/the mouse, the music will stop completely!  I have to
quit xmms/mpg123 and restart it for it to work again.  This only
happens with kernels I compile myself.  I have even tried compiling
2.2.10 and 2.3.6 with all default values, but still the same problem.
(Had same problem under r4!)  The only constant here is egcs 2.91.66,
which I built under r4 and which came prebuilt in r5.  This has been
extremely frustrating, as I'd like to start playing with the kernel
code myself.

Other problems:

2) Mouse: I cannot get the middle mouse button emulated using XFree86
- I've tried all the suggestions with the adb_buttons in the bootx
kernel-args space, and even tried the patched kernel in the
faq-o-matic; nothing.  Control-click does send a right mouse event and
has been from day 1, I just can't get the middle one emulated [I'd
actually like to get option and command-click *and* option-2/3 again, 
like r4].

3) twm menus are all blue in the background, until I move my mouse
over the selections, thus making them visible.  Here is a snip of my
.twmrc:

menu "hosts"
{
"Logins"        ("white":"DarkSlateGrey")       f.title
"Local Shell"   !"xterm &" #theres more here
...
"-----"         f.title
"Exit"          ("white":"CornFlowerBlue") f.quit
}

So, when I initially click, the menu is all blue until I move my mouse
over a selection, which then makes the selection act normal.  This
exact .twmrc worked perfectly under r4.

4) By the way, does anyone have a good /etc/X11/XF86Config file for
the PowerComputing's 17" monitor?  I don't have my monitor manual
here, so I don't have the exact h/v frequencies handy.  It works, but
I'm sure it'd work at a higher refresh rate (ie. 76hz)


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16
> > You are perfectly free to believe what you want to, and so am I.
> Actually, this turns out not to be the case. God does not give us
> the freedom to believe anything we wish. We are morally obligated to
> believe the truth. Doing anything else is a sin. You are not free to
> interpret the Bible anyway you wish. -DFL (Pretty neat, huh?)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
