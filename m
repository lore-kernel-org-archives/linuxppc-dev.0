Date: Tue, 7 Mar 2000 14:39:55 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Tim Riker <TimR@CalderaSystems.com>
cc: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>,
        linuxppc-dev@lists.linuxppc.org,
        linuxppc-workstation@lists.linuxppc.org
Subject: Re: bootloader ideas
In-Reply-To: <38C42165.3F7A6FEE@CalderaSystems.com>
Message-ID: <Pine.HPX.4.10.10003071435100.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 6 Mar 2000, Tim Riker wrote:

>
> I also believe that we need to move most of the platform-specific fixup
> code into a boot loader. I am looking into GRUB at this point:
>
> http://www.gnu.org/software/grub/
>
> The stage1 loader would need to have new ppc support, but this would
> allow for complete fs support in the stage2 loader.
>
> I will will look more at the other choices out there, but I've been real
> happy with grub on x86 and it is fairly clean code. stage2 is in C and
> shares much of the kernel FS code.

Most of the code is probably fine, with the probably non trivial problem
that stage1 uses the BIOS to load stage2. And even stage2 might still use
the BIOS to load the kernel. That's the major problem since depending on
the PPC machine the firmware services are very different (PPCBUG, ARC,
Open Firmware), when they can be made to work. Otherwise you've to add
additional device drivers.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
