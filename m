Message-ID: <396ACDF9.826580D3@amulet.co.jp>
Date: Tue, 11 Jul 2000 16:34:17 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Robert Thompson <rothomp3@vt.edu>
CC: pogtal@erols.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: trackpad
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert Thompson wrote:
>
> On Sat, 08 Jul 2000, Nelson Abramson wrote:
> >Assuming that you have not changed gpm's defaults, and that you have linked
> both
> >/dev/input/mouse and /dev/input/usbmouse to /dev/mouse, all you should need
> to do
> >is "gpm -t imps2", and that should allow gpm to take input from both your
> external
> >usb mouse and the trackpad.  If you have X use /dev/mouse, then it should
> also
> >beable to take input from both sources (it works for my Pismo).
> >
> Apparently this is an iBook specific issue, then, because I tried exactly
> this
> and is still doesn't work!

Nelson I didn't really follow that description. Ben's web page clearly
lists:

      su -
      cd /dev
      rm usbmouse
      rm mouse
      mkdir input
      mknod input/mice c 13 63
      ln -s input/mice mouse
      ln -s input/mice usbmouse

In the end, /dev/mouse and /dev/usbmouse are links to /dev/input/mice.
This is not the same as what you described above...

> Hmm... anybody have any clue what's different
> between the trackpad on the Pismo and on the iBook? It's not like ADB isn't
> working: the keyboard works fine, so ADB is working at least mostly fine.
> Like
> I said, I use an external trackball anyway, but I'm sure somebody will be
> angry
> about this at some point...

Robbie, I missed the beginning of the thread, but did you follow Ben's
directions?

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
