Message-ID: <3EFBCBA5.CCA3B63B@procsys.com>
Date: Fri, 27 Jun 2003 10:14:21 +0530
From: Nanda kumar <nanda@procsys.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: Conn Clark <clark@esteem.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: CompactFLASH driver for Linux
References: <3EF8CDF4.3050700@esteem.com> <3EFABFF4.9010707@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We are looking for a compactFLASH driver for Linux which runs over a PPC750. The
device we are using is Hitachi's 128MB FLASH part no -  HB28B128C8HSR. We are
planning to interface this directly without any IDE controller or PCMCIA interface.

How do we go about writing a driver for this ? Is there any standard driver available
for this ?

Any help will be appreciated

Thanks & Regards,
Nandan

Matthias Fuchs wrote:

> Hi Conn,
>
> we attached a CompactFlash socket to the 405's external bus on our CPCI405
> CompactPCI board. The board is directly supported by the linuxppc_2_4_devel tree.
> The tree includes a driver for simple memorymapped CompactFlash cards.
>
> Matthias
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
