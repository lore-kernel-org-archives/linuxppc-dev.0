Message-Id: <4.3.2.7.0.20000627155539.00af0c10@10.0.0.2>
Date: Tue, 27 Jun 2000 15:58:20 -0400
To: Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
From: Mike Coy <coym@embeddedplanet.com>
Subject: RE: PCMCIA ATA flash support
In-Reply-To: <A109131318C4D1119AC20060088DECE30B9824@amwmail.adaptivemic
 ro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


NIP is c00def58 (m8xx_ide_init_hwif_ports)
LR is c0002da4 (inside ide_init_hwif_ports)

I gather that LR is the place you were called from and NIP is the next
instruction, in which case both of these seem to be correct.

mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
