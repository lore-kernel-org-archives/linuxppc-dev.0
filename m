Date: Tue, 4 Jul 2000 09:25:52 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gianluca Costa <gcosta@essegi.net>
cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PReP kernel making
In-Reply-To: <3960A691.4934D982@essegi.net>
Message-ID: <Pine.HPX.4.10.10007040922010.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 3 Jul 2000, Gianluca Costa wrote:

>
> Hi,
>
> I am trying  to compile the 2.2.15 kernel sources (Debian potato for the
> ppc) for MCPN750 borad but
> I am not able to understand why my zImage don't run. The output from
> PPCBUG is:
> ...
> PPC1-Bug>nbo
>
> Network Booting from: DEC21143, Controller 0, Device 0
> Device Name: /pci@80000000/pci1011,19@e,0:0,0
> Loading: zImage
>
> Client IP Address      = 192.168.30.189
> Server IP Address      = 192.168.30.181
> Gateway IP Address     = 0.0.0.0
> Subnet IP Address Mask = 255.255.255.0
> Boot File Name         = zImage
> Argument File Name     =
>
> Network Boot File load in progress... To abort hit <BREAK>
>
> Bytes Received =&1021571, Bytes Loaded =&1021571
> Bytes/Second   =&340523, Elapsed Time=3 Second(s)
>
> Residual-Data Located at: $03F88000
>
> (end)
>
> I am using the default config that came with the kernel, but nothing
> changes.

Well, I don't know exactly how the MPCN750 work (I've only MVME boards),
but the images and the patches at ftp://vlab1.iram.es/pub/linux-2.[23]
help to boot kernels on Motorola machines with Raven/Falcon or HHawk host
bridges. This is as  much help as I can offer right now.

Do you use a hard disk (IDE or SCSI) or attempt to mount root via NFS ?

Do you need to other boards plugged into the CompactPCI backplane ?

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
