From: cpg@aladdin.de
Subject: Re: PCI-to-parallel port problem
To: berke@kis.uni-freiburg.de
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF270176E6.48AE87B6-ONC12569B9.006050DF@aladdin.de>
Date: Mon, 18 Dec 2000 18:35:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On 12/18/2000 05:55:30 PM CET Thomas Berkefeld wrote:
>
>I have FASTPCI 4008 PCI parallel port card from Dolphin Peripherals. To
>use the card,
>the manual tells to modprobe parport_pc.o with io-address and irq.
>Unfortunatley
>parport_pc.c cannot be compiled with
>kernel 2.4.0-test11 on my G4 Mac  (a header is missing).

You can copy the parport.h file from another architecture
subdirectory, I think they are (at least on i386, alpha and ia64)
the same. Then it should compile at least.

But when I compiled the parport modules they didn't find the
ports. I haven't looked much further into it yet...

regards,
chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
