Message-ID: <000701c28053$dd0f6610$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Hangs after "Now Booting the kernel "
Date: Thu, 31 Oct 2002 02:05:19 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I have build a image using the command make zImage.initrd. This gives a
linux image zImage.initrd.ebony[Ramdisk + Kernel Image]. This image run fine
in the PPC440 evalkit. However the same image if I run in my custom board
which has a 440GP processor, it hangs after saying "now booting the kernel".
What might be the problem ?.
I have one more question , is the TLB setting is reconfigured during linux
image booting , if so is it possible to get the memory map of that.

Thanking you in advance
regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
