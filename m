Message-ID: <39F8F00C.C6DF5AF4@mvista.com>
Date: Thu, 26 Oct 2000 20:01:32 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Early PCI auto-configuration
References: <39F8B44B.7980796@mvista.com> <19340920165843.29028@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >[The discussion below is based on the latest fsmlabs 5005 repository
> >code]
>
> You mean linuxppc_2_5, I guess ?
>
> >My problem:  The firmware on a couple platform I need to support do
> >absolutely _no_ PCI device initialization.

< stuff deleted >

> You may also want to look at pci_assign_unassigned_resources() (in
> drivers/pci/setup-res.c) and friends. They do things a bit differently,
> but it might match more closely what you want.

Note that pci_assign_unassigned_resources() gets called by the Alpha, MIPS,
and ARM kernels for this purpose, if I understand correctly...


--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
