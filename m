From: "Georg Klug" <gklug@giga-stream.de>
To: "caixupeng" <edmoon@huawei.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: AW: compile a linux kernel for ppc4xx, error message
Date: Fri, 22 Nov 2002 08:27:57 +0100
Message-ID: <FFECLICFNBJAHONLGAKMCEADCHAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <001501c291c2$04745150$33690b0a@DBKQW41X>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Edmoon,

the problem is most likely a wrong kernel source or a wrong .config.
There is a nice little howto on the web, actualy posted here a long time
ago. Try a google search with
   howto kernel compile walnut
and you'll find that posting.

Kind regards,
Georg Klug

> Dear all,
>
> I config the kernel as ppc4xx-->walnut ,a 405 based board. and make
> zImage,then
> I got the following error messages:
>
> {standard input}: Assembler messages:
> {standard input}:44: Error: unsupported relocation against DCRN_EXISR
> {standard input}:45: Error: unsupported relocation against DCRN_EXIER
> {standard input}:72: Error: unsupported relocation against DCRN_EXIER
> {standard input}:89: Error: unsupported relocation against DCRN_EXIER
> {standard input}:106: Error: unsupported relocation against DCRN_EXIER
> {standard input}:110: Error: unsupported relocation against DCRN_EXISR
> {standard input}:25: Error: unsupported relocation against DCRN_EXIER
> make[1]: *** [ppc4xx_pic.o] Error 1
> make[1]: Leaving directory `/usr/src/src-linuxppc_2_4/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
>
>
> another question:
>
> who has successed in compiling a linux kernel for ppc440GP?
>
> I have made my ebony board run ppcboot correctly, and I want compile
> and download a
>
> linux kernel to the ebony board.
>
> who can help me?
>
> thanks!
>
>             edmoon


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
