Message-ID: <9CFB9DA5261CD611A29B00508B78904807F880E4@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: m.venkatraj@exgate.tek.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: ADS860 - unable to load kernel- Bad magic number
Date: Fri, 27 Feb 2004 09:27:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

when using u-boot you need an Linux image which is
created with "mkimage" tool.

Try "make uImage" which will create this
image in arch/ppc/boot/image.

See also:
(http://www.denx.de/twiki/bin/view/DULG/Manual)

Regards,
Torsten


> -----Original Message-----
> From: m.venkatraj@exgate.tek.com [mailto:m.venkatraj@exgate.tek.com]
> Sent: Freitag, 27. Februar 2004 05:35
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: ADS860 - unable to load kernel- Bad magic number
>
>
>
> Hi,
>
> I am a linux-newbie working on a parallel track on the MPC
> 860, on a ADS
> board. I am facing difficulty in getting the kernel to load.
> This is what I
> have done so far:
>
> - built a cross-toolchain using Dan Kegel's crosstool.
> - built u-boot-1.0.1 and flashed it to the board using BDI2000
> - built linus-2.4.22, (with the below mentioned patch on last
> attempt).
>
> The compilation goes through fine, I get "vmlinux" on the
> top-dir, and also
> a vmlinux.gz in the arch/ppc/boot/images if I do a "make zImage".
>
> When I configure bootp, and bootup the board, u-boot comes up
> fine, the tftp
> download of the kernel image goes through fine too. Then I am
> stuck with a
> "Bad Magic Number". Some initial digup led me to a mismatched
> image header
> magic number.
>
> Could anyone please help me with how to go ahead? Am I
> missing something?
>
> Also thanks to everyone whose postings on this and other
> lists helped me get
> started!
>
> Venkatraj M.
> Tektronix.
>
> -----Original Message-----
> From: Xavier Miville [mailto:xmiville@oerlikon.ca]
> Sent: Thursday, February 26, 2004 9:58 PM
> To: Sudeep, V
> Cc: samsongshzu@yahoo.com.cn; wd@denx.de; mporter@kernel.crashing.org;
> laurent.mohin@acterna.com; linuxppc-embedded@lists.linuxppc.org
> Subject: RE: PCI daughter card with USB on a 405GP
>
>
>
> You will need to apply the corresponding linuxppc patch
> (/pub/linux/kernel/ports/ppc/2.4) to 2.4.22. The zvmlinux doesn't seem
> to be built with only 2.4.22.
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
