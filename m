From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8560 boot console (CPM SCC) driver problem
Date: Tue, 24 Aug 2004 18:22:32 +0200
Message-ID: <001201c489f6$926db540$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I download a 2.6.8 Linux kernel to port it to a custom 8560 board
similar to MPC8560_ADS board..

In the arch/ppc/boot directory there is no 85xx_io directory with
a CPM uart driver.

The kernel link waits for some serial basic functions like serial_getc().

I found the generic ./drivers/serial/cpm_uart driver, but it seems to only
be
used later when Linux is installed.

Surely I miss something.
How can I have a console for my boot ?
Are 8260 cpm2 definitions compatible with 85xx ?

Thanks
Gérard Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
