From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Matt Porter" <mporter@mvista.com>
Cc: "Linuxppc-Dev" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Bogus interrupt + little Makefile bug
Date: Thu, 1 Mar 2001 10:55:33 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMKEJBCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010228171203.A29030@beef.az.mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ok, I finally got time today to powerup the 5100 that's been laying
> around here.  I just pushed the port to the linuxppc_2_5 tree.
> Hopefully this saves some effort for others.

Very great work !!!

I have found a little bug in arch/ppc/boot/pp3/Makefile:
the rule to make zImage.initrd miss the -pbp option in the mkprep
invocation.

I've seen that in the make menuconfig, selecting the MVME5100, does not
display the possibility to specify the default kernel command line. Don't
you think this is an useful option ?

Bye.
Stefano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
