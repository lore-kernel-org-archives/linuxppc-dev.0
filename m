MIME-Version: 1.0
Subject: RE: Hangs after "Now Booting the kernel "
Date: Thu, 31 Oct 2002 10:20:41 +0530
Message-ID: <4223A04BF7D1B941A25246ADD0462FF5026B22@blr-m3-msg.wipro.com>
From: "Prabhu Kubendran" <prabhu.kubendran@wipro.com>
To: "Aman" <aman@mistralsoftware.com>,
	"linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Aman,
	you may need to select a different processor type for your custom
board. In make menuconfig, go to platform support, click on processor
type, check if you have your processor option available on the list and
select it.

regard,
prabu


-----Original Message-----
From:	Aman [mailto:aman@mistralsoftware.com]
Sent:	Thu 10/31/2002 2:05 AM
To:	linuxppc embedded
Subject:	Hangs after "Now Booting the kernel "

I have build a image using the command make zImage.initrd. This gives a
linux image zImage.initrd.ebony[Ramdisk + Kernel Image]. This image run fine
in the PPC440 evalkit. However the same image if I run in my custom board
which has a 440GP processor, it hangs after saying "now booting the kernel".
What might be the problem ?.
I have one more question , is the TLB setting is reconfigured during linux
image booting , if so is it possible to get the memory map of that.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
