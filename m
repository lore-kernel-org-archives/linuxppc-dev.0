Date: Wed, 29 May 2002 13:48:22 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Unrecognized opcode: `mtdcr'
Message-ID: <20020529134822.A4429@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just started trying to play with my new Ebony board...

I noticed now 'as' complains: Unrecognized opcode: `mtdcr'
when I do this:
	make ebony_config
	make mrproper
	make menuconfig
	make dep
	make zImage

But, if I do this:
	make walnut_config
	make mrproper
	make menuconfig
	make dpe
	make zImage

I can make a zImage just fine.

Of course I can manually add '-Wa,-m405' into my CFLAGS in
the Makefile, and it will build ok, but I'm thinking that's
not what I want to do.

My 'as' says:

[scameron@zuul sslinux]$ /usr/local/powerpc-linux/bin/as --version
GNU assembler 2.12
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `powerpc-linux'.

I also tried binutils 2.12.1, with the same results.

Any ideas?

Thanks,

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
