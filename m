Date: Wed, 18 Oct 2000 13:53:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Xavier Grave <grave@ipno.in2p3.fr>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: initial console
In-Reply-To: <Pine.LNX.4.21.0010181325230.24224-100000@ipnpcu5>
Message-ID: <Pine.HPX.4.10.10010181350180.18996-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Oct 2000, Xavier Grave wrote:

> On Wed, 18 Oct 2000, Gabriel Paubert wrote:
> >
> > CONFIG_SERIAL_CONSOLE is missing ?
> grep CONFIG_SERIAL_CONSOLE .config
> CONFIG_SERIAL_CONSOLE=y
>
> > console=ttyS0
> With or without the same result...
>
> > > pc_keyb: controller jammed (0xFF).
> > > pc_keyb: controller jammed (0xFF).
> > > and so on...
> >
> >
> > Expected with an MVME2300.
> The error message disappeared after a few hundred of message.
>
> > P.S:  I still don't understand why my bootloader would not properly
> > reconfigure the PCI resources to give you access to the SCSI board.
> > Do you have somewhere a printout of the bootlog, it should list all the
> > PCI resources before and after reorganization.
> Sorry, I've lost the output of the kernel I have compiled with your patch.
> Can I use your patch with the latest linuxppc_2_5 from fsmlab ?
> If so I'll try it one more time. But the actual kernel (from
> fsmlab) recognize and configure my SCSI board.

No, all my patches are relative to the official kernel tree. I have
2.4.0-test9 running on an MVME2600 right now (built in NCR53C825).
It might be a sym53c8xx driver problem too, I have only used ncr53c8xx.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
