Mime-Version: 1.0
Message-Id: <v04220800b565e4500d98@[192.168.0.1]>
In-Reply-To: <v04220811b565bafd4b4b@[206.6.156.5]>
References: <v04220811b565bafd4b4b@[206.6.156.5]>
Date: Thu, 8 Jun 2000 20:05:04 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: compiling new imsttfb?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was browsing comp.os.linux.powerpc and saw mention of a new
imsttfb.c that I nabbed off <http://fortyoz.org/~ror/linux/>.

For grins I thought I'd try compiling this new imsttfb.c (dated
22-May) in with the 2.2.15 linux-pmac-stable (rsynced about 2 weeks
ago).

But, the new imsttfb.c is substantially different than the one
included with the rsynced version. In particular, the entire
imsttfb_of_init function is excised, and this causes the compile to
fail:

offb.o(.text.init+0x47c): undefined reference to `imsttfb_of_init'
offb.o(.text.init+0x47c): relocation truncated to fit: R_PPC_REL24
imsttfb_of_init
make: *** [vmlinux] Error 1

Is there any easy way to modify this properly? My intuition is
telling me that this new imsttfb is so different it won't compile
under any circumstances with the linux source I have, regardless of
my question above. Is there a better version I can try?

I have a Linux box with a Twin Turbo card in it, and despite being
pretty good IMHO with trying out different kernel video arguments, I
see exactly the same effects described on this list when acceleration
is attempted: in X, any window is drawn correctly initially, but
dragging it anywhere automatically defracts the entire screen into
split horizontal lines.

So I'm looking at this imsttfb issue on the side. Any suggestions?


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
