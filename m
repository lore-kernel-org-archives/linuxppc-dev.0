Message-ID: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: <pogtal@erols.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: re: trackpad
Date: Mon, 10 Jul 2000 15:38:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 08 Jul 2000, Nelson Abramson wrote:
>Assuming that you have not changed gpm's defaults, and that you have linked
both
>/dev/input/mouse and /dev/input/usbmouse to /dev/mouse, all you should need
to do
>is "gpm -t imps2", and that should allow gpm to take input from both your
external
>usb mouse and the trackpad.  If you have X use /dev/mouse, then it should
also
>beable to take input from both sources (it works for my Pismo).
>
Apparently this is an iBook specific issue, then, because I tried exactly
this
and is still doesn't work! Hmm... anybody have any clue what's different
between the trackpad on the Pismo and on the iBook? It's not like ADB isn't
working: the keyboard works fine, so ADB is working at least mostly fine.
Like
I said, I use an external trackball anyway, but I'm sure somebody will be
angry
about this at some point...

Thanks,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
