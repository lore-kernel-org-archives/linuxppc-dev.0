Message-Id: <v03110700b4eed612282b@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Mar 2000 11:45:17 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: aty128fb does not work in newer sawtooth machines
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just received last week a new G4 at 450Mhz.  I have been trying various
things to get the video working properly to no avail.

If you use yaboot and boot with the following arguments:
video=aty128fb:vmode:17

then you get a working 1024x768 video at 8bpp

If you however try anything else at higher depths you end up with a screen
that is split into 3 vertical panes that make it impossible to use.

For example:

video=aty128fb:vmode18,cmode:32

which works fine on my B+W G3 immediately gives the three panes in console
mode.

The same problems exist in both Xpmac and XFree86 3.9.18.

Solutions anyone?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
