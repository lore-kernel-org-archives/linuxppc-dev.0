To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LIB_PATH for cross compiling 
In-Reply-To: Message from Michael Habermann <MHabermann@gmx.de>
   of "Wed, 16 May 2001 13:41:23 +0800." <5.0.2.1.0.20010516132449.00a248b0@pop.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 16:08:39 +1000
Message-ID: <29960.989993319@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 16 May 2001 13:41:23 +0800, Michael Habermann <MHabermann@gmx.de> writes:
>I cross compile from i386 to ppc. If I compile a simple C program, the
>linker searchs the libc.so.6 in the /lib path instead of the
>/usr/local/powerpc-linux/lib.

I think you need to edit the file "/usr/local/powerpc-linux/lib/libc.so".
You will find it is a text file that looks like this:

/* GNU ld script
   Use the shared library, but some functions are only in
   the static library, so try that secondarily.  */
GROUP ( /lib/libc.so.6 /usr/lib/libc_nonshared.a )

change "/lib" and "/usr/lib" to be "/usr/local/powerpc-linux/lib" in the above
file (do it automatically with a script as part of the installation of glibc).
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
