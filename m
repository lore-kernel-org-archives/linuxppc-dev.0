Date: Wed, 18 Oct 2000 13:46:38 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.HPX.4.10.10010181154300.18996-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0010181325230.24224-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Oct 2000, Gabriel Paubert wrote:
>
> CONFIG_SERIAL_CONSOLE is missing ?
grep CONFIG_SERIAL_CONSOLE .config
CONFIG_SERIAL_CONSOLE=y

> console=ttyS0
With or without the same result...

> > pc_keyb: controller jammed (0xFF).
> > pc_keyb: controller jammed (0xFF).
> > and so on...
>
>
> Expected with an MVME2300.
The error message disappeared after a few hundred of message.

> P.S:  I still don't understand why my bootloader would not properly
> reconfigure the PCI resources to give you access to the SCSI board.
> Do you have somewhere a printout of the bootlog, it should list all the
> PCI resources before and after reorganization.
Sorry, I've lost the output of the kernel I have compiled with your patch.
Can I use your patch with the latest linuxppc_2_5 from fsmlab ?
If so I'll try it one more time. But the actual kernel (from
fsmlab) recognize and configure my SCSI board.

xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
