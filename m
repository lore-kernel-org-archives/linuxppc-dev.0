Message-ID: <B25E2E5A003CD311B61E00902778AF2A02637AB3@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Matthias Fuchs'" <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: simple access to mem mapped peripheral
Date: Tue, 2 Oct 2001 07:53:52 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

May be try this?

	chip_registerbase = (unsigned
long)ioremap_nocache(CHIP_PHYSICAL_ADDRESS,
    			CHIP_MEM_SIZE);
	printk("Linux kernel Memory mapped base register %lX \n",
chip_registerbase);

Then you can read and write to your chip via *chip_registerbase

/Subodh

-----Original Message-----
From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
Sent: Tuesday, October 02, 2001 10:02 AM
To: linuxppc-embedded
Subject: simple access to mem mapped peripheral



Hi,

I need a "very simple" way to access a mem mapped peripheral. The device
is mem mapped at 0xf0200000.
I was trying /dev/mem but this dev only accesses my physical memory
chips.

My target is a ppc405gp running recent kernel 2.4.10.

Any idea ?

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
