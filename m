Return-Path: <powerpc440@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id 11BECDDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Apr 2007 00:22:07 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so1322868mue
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 02 Apr 2007 07:22:05 -0700 (PDT)
Message-ID: <4611124C.7000903@googlemail.com>
Date: Mon, 02 Apr 2007 16:25:16 +0200
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: vbetool and x86emu compile problem
References: <mailman.1.1175479202.12039.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.1.1175479202.12039.linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
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

I have ppc405ep custom board with PCI slot. In the slot is a standard
PCI Graphic adapter (Radeon 7000). Of course the card is not low-level
initialized and I can't obtain any image, neither with Kernel's frame
buffer driver nor xorg's radeon driver. With vbetool is possible to
enable the video BIOS of the graphic adapter. My problem is that, I
can't compile vbetool on my  PPC board, seems to be platform
compatibility problems, also with x86emu key enabled. I think that,
vbetool till now is only for x86, and AMD 64bit platforms suitable.
Have somebody succeed to compile vbetools on PPC platform and when yes -
how?
Are there another possibilities to low-level initialize the video card,
may be still in u-boot or Linux kernel?

Thank you in advance!

Best regards,
Zhivko Yordanov
