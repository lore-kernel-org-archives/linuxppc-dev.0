Date: Sat, 28 Aug 1999 15:17:30 -0400
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: Re: lost Button2 in upgrade to 2.2.10
In-Reply-To: <Pine.SGI.4.00.9908221825100.5682-100000@osiris.office.aol.com
 >
Message-ID: <Pine.SGI.4.00.9908281507170.18678-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I booted back into 2.2.10 to give this another try.

I'm using kernel 2.2.10-rev2-mol.

I'm using the XKB Patched:
	/usr/lib/X11/xkb/compat/mousekeys
	/usr/lib/X11/xkb/geometry/macintosh
	/usr/lib/X11/xkb/keycodes/macintosh
	/usr/lib/X11/xkb/symbols/macintosh/us
	/etc/X11/XF86Config

I'm using: 
	/etc/sysconfig/mouse-2.2.10
	/etc/sysconfig/keyboard-2.2.10

I have a Logitech MouseMan Wheel USB.

I boot into 2.2.10, everything works except Mouse Button2 is no longer
recognized.  xev doesn't even get anything back from pressing Button2. 
It worked fine in 2.2.6.

I run /usr/sbin/mouseconfig.  It's set for Bus 1, 3 button emulation.

If I save the changes with mouseconfig it overwrites /etc/sysconfig/mouse
back to "BusMouse" instead of "IMPS/2".

Any ideas why Mouse Button2 would not work with 2.2.10 but works with
2.2.6?

-b


On Sun, 22 Aug 1999, brad allison wrote:

> 
> 
> I upgraded my G3 450 to 2.2.10 today.  I've been running 2.2.6.
> 
> I pulled the keyboard-2.2.10 and mouse-2.2.10 files and linked them in
> /etc/sysconfig correctly.
> 
> Booted into linux without a problem.
> 
> But now Button2 no longer works.  I'm using a Logitech MouseMan Wheel USB 
> 3 button mouse.
> 
> I ran xev to see what Button2 was mapped to.  Button1 shows up as Button1.
> Button3 shows up as Button3.  Button2 shows up as nothing.  xev registered
> nothing.
> 
> Again, all three buttons worked correctly with 2.2.6.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
