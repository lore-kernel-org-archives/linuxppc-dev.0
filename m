Return-Path: <jessicac@tccomm.com>
Received: from smtpout04-04.prod.mesa1.secureserver.net
	(smtpout04-04.prod.mesa1.secureserver.net [64.202.165.199])
	by ozlabs.org (Postfix) with SMTP id 894BC679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Apr 2006 10:03:27 +1000 (EST)
Message-ID: <002701c6601f$15b27f30$9afea8c0@tcdomain.com>
From: "Jessica Chen" <jessicac@tccomm.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Port Linux w/ mbxboot to PPCBoot system
Date: Fri, 14 Apr 2006 16:56:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,



     I am new to embedded system, I am studying ppcboot-1.1.5 and linux
kernel-2.4.4 that comes with an mpc852 base board, we want to modify it in
the future.  In the build process, they use the zImage.initrd
(arch/ppc/mbxboot/zvmlinux.initrd) instead of the raw Linux kernel image
(arch/ppc/coffboot/vmlinux.gz) + separate initrd which is the way README
file suggested.



My question is:

since ppcboot is already running, what happens when I boot the kernel that
has old boot loader code in arch/ppc/mbxboot?  Will some parameters be
overwritten?  If not, why?



     I am very tempted to follow the README to re-build the kernel with only
vmlinux.gz and port it, but I don't want to create any un-recoverable
results.  So I am here to seek advice, maybe this is something obvious to
many people.



Thanks in advance,





Jessica Chen
