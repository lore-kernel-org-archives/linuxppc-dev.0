Message-ID: <38EAD4E8.61CD5BCA@astro.wisc.edu>
Date: Wed, 05 Apr 2000 00:53:44 -0500
From: Matt Haffner <haffner@astro.wisc.edu>
Reply-To: haffner@astro.wisc.edu
MIME-Version: 1.0
To: Linux Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: XFree 4 & sound problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm a little confused why there is a problem with XFree 4 and sound
since I wouldn't think XFree does anything with it, but I'm getting hard
freezes when playing MP3's in XMMS and mpg123 whenever I do significant
X actions (switching desktops, starting Netscape, mousing a menu, etc.).
If I just let things go and don't touch anything, it plays fine. The
freeze requires a reset button reboot--the machine is not reachable at
all (i.e. it's not just X).

I'm on a rev. 1 B&W with a 2K install and 2.2.15pre14. These are the
only kernel sound flags set in my build:

CONFIG_SOUND=y

CONFIG_DMASOUND=y

CONFIG_SOUND_OSS=y
       (tried 'n' as well here since I thought dma took care of it all)

I suppose it could be a more subtle interaction with the new kernel as
well. I had pre3 originally but had to upgrade for XFree 4 USB. However,
I can play songs from a VT without running X with mpg123 without
trouble. Also, if I switch back to Xpmac.r128, everything works again
without crashing even under the new kernel.

Anyone else having this problem? I'm happy to muck around if you have an
idea where I can start looking for the problem. Is enabling any of the
kernel debugging options worthwhile in these hard freezes or is it too
quick to trigger any useful dumping?

mh
--
Matt Haffner                      /|------|\    University of Wisconsin
Dept. of Astronomy               /|--------|\            Madison
haffner@astro.wisc.edu          /|----------|\
           WHAM project -- http://www.astro.wisc.edu/wham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
