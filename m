From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: Aron.J.Silverton@motorola.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Cross-compile package combinations
Date: Wed, 10 Dec 2003 19:28:45 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F43XBirbThA9QR0004126e@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aron,

I've recently done just this, same host and target. I used GCC 3.2.3 with
GLIBC 2.3.2 w/ Linuxthreads and Binutils 2.14. This worked fine.

Check out a package called "crosstools". It's a nice tool that will tell you
about working combinations, actaully download these tarballs off the web,
find any applicable patches, apply them, configure the tools for your host
and target, build them and finally install it at your deisred location. All
this from running a single SHELL file. This is what I did and it worked like
a charm.

I've currently used this toolchain to compile 2.4.x kernels, haven't tried
2.6.x.

Contact me if you want any more details.

~Ashwin

_________________________________________________________________
Winterize your home with tips from MSN House & Home.
http://special.msn.com/home/warmhome.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
