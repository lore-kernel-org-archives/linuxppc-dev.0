Message-ID: <387E2122.4D258AF0@ruf.uni-freiburg.de>
Date: Thu, 13 Jan 2000 19:01:54 +0000
From: Robert Roebling <roebling@ruf.uni-freiburg.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: X11 pixel value on bigendian PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  Hi,

I'm the main authour of the Linux port of the 
wxWindows GUI library and I need help from one
of you to make wxWindows work on LinuxPPC as
well as elsewhere. I'm sure that 99.9% of the
library will work equally as on my intel, but
I have one lingering problem, and that is that
PowerPC are probably bigendian. Not much of a
problem in most cases, but when converting image
data under X11 (or GTK for that matter) this
plays a role. I had no problem to write image
conversion routines for 8-bit displays (no change
in big vs. little endian) and on 24-bit systems
(just exchange RGB bytes), but for 15 and 16 bit
visuals, I'm stuck with no machine I could test
this on (the Suns I can use have either 8-bit or
24-bit) and no info either. Do you have any info
on the meaning of bits on a big-endian computer
in the pixel value, that is returned by an XGetPixel()
call ona 16- and on a 15-bit visual? If not, maybe
someone who has access to a big-endian machine with
such a visual could have a look at the relevant
source in wxWindow and see what happens? Just for
information, wxWindows can be found here:

  http://wesley.informatik.uni-freiburg.de/~wxxt

and the code that poses problem is in file

  wxGTK/src/common/image.cpp

lines 1610 and following,

  Regards,

     Robert Roebling

I'm not subscribed to this list.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
