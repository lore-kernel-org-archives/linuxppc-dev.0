Date: Fri, 14 Jul 2000 12:00:58 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Crusman <Crusman@wanadoo.fr>
cc: ppc_mailing <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: your mail
In-Reply-To: <001e01bfed04$b27494a0$29e58aa4@crusman>
Message-ID: <Pine.HPX.4.10.10007141157010.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 13 Jul 2000, Crusman wrote:

> >The configurations I have are for 2600 with a PMC graphics board, remove
> >CONFIG_VT from the setup and it will use a serial console.
> >
> >BTW use PrePboot for these boards (CONFIG_PREPBOOT) since it gives a nicer
> >PCI layout to access the VMEbus...
> >
> >Please use the patches mvme2600.*.bz2...
>
> I have tested the patches but the new kernel don't see the scsi device...so
> I can't try it anyway !

Did you try the nfsroot (or nfsinstall but it's probably broken now) ? The
nfsroot does not have any CONFIG_VT set so it should work. At least it
works on headless 2600 and 2400.

> Yes, I have tested your kernel, but there is a message ( PC keyb error... or
> something like this) wich lock the kernel during the boot ! It's probably
> due to the Virtual Terminal support in the kernel !
> I always use the "console=ttyS0,9600" kernel option.

Then it should not do this, I don't know what happens. AFAIR it works on
MVME2400 whcih don't have the KB controller either.

> In short :
>
> - I can't use your kernel because of the PC_key error !
> - I can't patch & build a new kernel because this new kernel don't see my
> SCSI PMC !

Did you ever see the PMC module with some kernel ? Once booted (an nfsrrot
system is the best for this), see what you have in /proc/bus/pci.

	Gabriel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
