Message-ID: <B0011235688@mail.olg.com>
Date: Thu, 29 Jul 1999 23:57:03 -0400
Subject: X/CLUT/pixel data format question WRT IMSTT cards
From: "charlie buckheit" <buckheit@olg.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I was wondering if someone who understands the Xserver code a little better
can first point me in the direction of the code that sets the CLUT for X,
second if any information on the pixel data formats for the various color
modes is available, and third if the Xserver runs in true color mode or does
it only use the color lookup tables. I'm trying to figure out why the IMSTT
card is still having problems in 16 and 24/32 bpp modes. I pretty much
proved to myself that its not an endian problem (I've got IXMicro provided
code and API manuals for the chipsets) as when I write directly to the video
memory the results on the screen are correct (i.e. in 24/32 bpp writting
0x000000ff to the screen results in blue, 0x0000ff00 green, 0x00ff0000 red,
and 0xff000000 in black as the most significant 8 bits are the alpha data
which is not used). On my computer the greys are correct (telling me that
the RGB registers are probably correct as all three must be the same value
to get greys in true color mode), and images displayed in GIMP are fine
(this can't be pure luck can it???)...its just the gnome/enlightenment stuff
thats messed up...specifically the icons and window borders. So my thought
now is that either the X pixel formats are different then the IMSTT card
expects or the CLUT is not getting set correctly or X doesn't like the true
color mode.

BTW 16bpp is a completely different animal though I think the problems are
related as the colors are correct there also when written manually to the
screen.

Anyway, any help would be greatly appreciated...

VR, Charlie


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
