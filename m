Date: Mon, 14 Jun 1999 09:12:25 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: "Henry A. Leinhos" <leinhos@arwyn.npt.nuwc.navy.mil>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel for MVME 1600
In-Reply-To: <37600530.8D2E52B8@arwyn.npt.nuwc.navy.mil>
Message-ID: <Pine.HPP.3.96.990614090951.21444B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 10 Jun 1999, Henry A. Leinhos wrote:

	Hi, 

> 
> Hi,
> 
> I've been trying to compile the 2.2.4 kernel using Garbiel's patches,
> and everything seems to go fine until the final step (in make zImage). 
> I (unfortunately) know only enough about this card to be dangerous, and

We all go through this point ;-)

> get the following ld error messages:
> 
> make[1]: Entering directory `/home/leinhos/src/linux/arch/ppc/prepboot'
> objcopy /home/leinhos/src/linux/vmlinux vmlinux -O binary -R .comment -S
> gzip -vf9 vmlinux
> vmlinux:                 58.6% -- replaced with vmlinux.gz
> ld -o zImage head.o misc.o mm.o exception.o pci.o zlib.o em86.o
> em86real.o console.o ravenfalcon.o
> --just-symbols=/home/leinhos/src/linux/vmlinux \
> -b binary vmlinux.gz -T ppcboot.lds -Map zImage.map
> head.o: In function `start':
> head.o(.text+0x76): relocation truncated to fit: R_PPC_SECTOFF_HA __size
> head.o(.text+0x82): relocation truncated to fit: R_PPC_SECTOFF_LO __size
> head.o(.text+0xba): relocation truncated to fit: R_PPC_SECTOFF_HA _edata
> head.o(.text+0xc2): relocation truncated to fit: R_PPC_SECTOFF_LO _edata
> head.o(.text+0x15a): relocation truncated to fit: R_PPC_SECTOFF_HA __size
> head.o(.text+0x15e): relocation truncated to fit: R_PPC_SECTOFF_LO __size
> head.o(.text+0x176): relocation truncated to fit: R_PPC_SECTOFF_HA _vmlinux_gz_size
> head.o(.text+0x17e): relocation truncated to fit: R_PPC_SECTOFF_HA _vmlinux_size
> head.o(.text+0x186): relocation truncated to fit: R_PPC_SECTOFF_LO _vmlinux_gz_size
> head.o(.text+0x18a): relocation truncated to fit: R_PPC_SECTOFF_LO _vmlinux_size
> make[1]: *** [zImage] Error 1
> make[1]: Leaving directory `/home/leinhos/src/linux/arch/ppc/prepboot'
> make: *** [zImage] Error 2

Upgrade your binutils, I don't remember in which version I fixed that bug
but it is a binutils bug. 

	Regards,
	Gabriel.

P.S: on the other hand I'm not sure that it will boot on a 1600, I only
have 2000 series (2600 myself, but other people have used 2300, 2400 and
2700 AFAIR). 





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
