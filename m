In-Reply-To: <Pine.GSO.4.58.0405191047150.23702@waterleaf.sonytel.be>
Subject: Re: getting linux console on a frame buffer.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: geert@sonycom.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Message-ID: <OFE905D2F1.566CE02A-ON85256E99.0046D4AF-85256E99.00478089@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 19 May 2004 09:00:59 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

Thanks so much for responding to my cry for help.  I owe you one fresh cold
virtual beer! =)

> On Tue, 18 May 2004, David Ho wrote:
> > I have a 240*320 16bpp LCD (framebuffer) attached to a MPC852T that I
have
> > trouble running simple tests like rendering an image directly to the
> > framebuffer using fbi from Gerd Knorr.  I have already dump rawimage by
> > catting to the /dev/fb0 device.  I am at a point where I like to
understand
> > the byte ordering and image rendering issues with jpeg and png files.
>
> Have you tried fbtest (CVS module fbtest at
www.sf.net/projects/linux-fbdev/)?

I haven't try this so I'll get right on it as soon as I have my console
running on the frame buffer.

>
> > The problem may be that I don't have a linux console running on the
frame
> > buffer device.  Would anyone know how to get the linux console on the
frame
> > buffer but still receives input from a serial port (I don't have a
keyboard
> > attached to the board.  I have been doing most things from the serial
> > console and remotely).
>
> Append `console=tty0 console=ttyS0' to the kernel command line, and
kernel
> messages will appear on both tty0 (fb) and ttyS0 (serial), while console
input
> will be taken from the last one (ttyS0).

I tried your suggestion, but I noticed tty's are not initialized in my
kernel startup log.  I'll looking into how I can start it.  Otherwise, I
lost the console (it does not appear on either tty0(fb) or ttyS0 (serial).

Thanks, David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
