Message-ID: <001701c26c5f$647b72a0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Fw: HHL 2.1 preview kit
Date: Sat, 5 Oct 2002 13:07:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the answer, I have got the image.

Unfortunately the Image doesn' t run. The problem is derived from the
loading the image file.
The boot loader is PPCboot 1.0.5 and the "vmlinux.gz" has been converted
with the "mkimage" utility. The bootloader is able to download the image
generated with the CDK 1.2 (kernel 2.4.0-test2) but when it downloads the
image which is the result of new compilation (HHL 2.1), program is stuck
after the decompression.

Anybody has some suggestions to give me?


Thanks
Gianfranco

----- Original Message -----
From: "Yu Bo-BOYU1" <Bo.Yu@motorola.com>
To: "'Ing.Gianfranco Morandi'" <gianfranco.morandi@euro-studio.it>;
"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, October 03, 2002 4:20 PM
Subject: RE: HHL 2.1 preview kit


> you need to change some definitions in makefile
>
> ARCH := ppc
> CROSS_COMPILE = ppc_82xx-
>
> Bo
>
> -----Original Message-----
> From: Ing.Gianfranco Morandi [mailto:gianfranco.morandi@euro-studio.it]
> Sent: Thursday, October 03, 2002 9:11 AM
> To: LinuxPPC
> Subject: HHL 2.1 preview kit
>
>
>
> Hi to all,
>
> I have a question regarding the preview kit of Montavista.
>
> I have downloaded the CD Image and installed the tools for the Sandpoint
> 8240 (which should be an 82xx architecture).
>
> When I try to configure the kernel with "make config" command, no
processor
> other than x86 can be selected.
> In other word I cannot select the Power PC architecture.
>
> I would like to install the kit for the EST8260 board and I thought that
> such installation was a good base to start.
>
> Anybody has suggestions to give me?
>
> Any help is appreciated.
>
> Gianfranco
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
