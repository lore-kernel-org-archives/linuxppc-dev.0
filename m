MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MTD Driver (denx Linux 2.4.4)
Date: Thu, 31 Oct 2002 16:37:14 +0200
Message-ID: <1E354700654661418593A0D6B5A9D410089481@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I'm having difficulty in getting the MTD driver working. I'm using a
non-CFI complaint Sharp chip so I have defined CONFIG_MTD_SHARP. However
I cannot locate anywhere in the code where the kernel will call
sharp_probe_init. In any case I forced init_mtd (mtdcore.c) to call
sharp_probe_init and it seems to load the driver okay as I see the
following on my serial console

JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
Communications AB.
MTD Sharp chip driver <ds@lineo.com>
MTD Sharp chip driver <ds@lineo.com>

Now my question is, do I need to force this driver to load or am I
missing some compile flag? How do I go about partitioning the flash, ie
how does this driver link to a flash map?

Any help would be appreciated

Thanks in advance
Flavio Pereira


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
