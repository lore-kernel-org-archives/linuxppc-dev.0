From: Amit.Lubovsky@infineon.com
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E4851@ntah901e.savan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: pci on MBX860
Date: Sun, 5 Oct 2003 09:43:45 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello MBX860 developers,
I post this question again since haven't got any reply yet...(anyone ?)

> Does anyone have any experience with pci on the MBX860 board ?
>
> I run kernel 2.4.20 from www.denx.de but encountered compilation problems
> after trying to configure pci.
>
> this is the output of what I got:
>
> kernel configuration:
>
> I have enabled General setup-> QSpan PCI
>
>
> and then while compiling the kernel got:
>
> make uImage
> ...
>
> ppc_8xx-gcc -D__KERNEL__ -I/opt/eldk/usr/src/linuxppc_2_4_devel/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -fomit-frame-pointer
> -I/opt/eldk/usr/src/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float
> -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -I
> /opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.4/include
> -DKBUILD_BASENAME=m8xx_setup  -c -o m8xx_setup.o m8xx_setup.c
> m8xx_setup.c: In function `m8xx_show_percpuinfo':
> m8xx_setup.c:252: warning: int format, long int arg (arg 3)
> m8xx_setup.c:252: warning: int format, long int arg (arg 4)
> m8xx_setup.c: In function `m8xx_init_IRQ':
> m8xx_setup.c:281: structure has no member named `irq_offset'
> m8xx_setup.c: In function `platform_init':
> m8xx_setup.c:357: warning: implicit declaration of function
> `m8xx_setup_pci_ptrs'
> make[1]: *** [m8xx_setup.o] Error 1
> make[1]: Leaving directory
> `/opt/eldk/usr/src/linuxppc_2_4_devel/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
> [root@amit_lap linuxppc_2_4_devel]#
>
> any info is appreciated,
> Thanks,
> Amit.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
