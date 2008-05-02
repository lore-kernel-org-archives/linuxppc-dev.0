Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id DCB36DE049
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 May 2008 00:11:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: treeImage vs cuImage
Date: Fri, 2 May 2008 07:14:27 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109583679@tranzeo-mail2.12stewart.tranzeo.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "LinuxPPC-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am upgrading my BSP to 2.6.25 and notice cuImage and treeImage.  The
source files both say Old U-Boot compatibility.

Someone please educate me (or point me to a good URL that explains) as
to what the difference is.

I want to be able to load the kernel image using an older U-Boot and
currently use cuImage for 2.6.23 arch/powerpc (and plain uImage for
older kernels under arch/ppc).

Eventually, I want to generate both an old U-Boot compatible image and a
new U-boot compatible image.

I notice that some boards, the boot support is all in one file, in
others, it is split between cuboot-<board>.c and <board>.c.  In the case
of ebony board, I see support for both cuImage and treeImage.  Is the
strcuture into multiple files to ensure that ebony supports both of
these and new U-boot support as well?

I would like to make my BSP modules lean and clean enough to eventually
send back upstream to kernel.org.

Also, if there are common snags / pitfalls I need to watch out for
switching my BSP and DTS from 2.6.23 to 2.6.25, please warn me.

I am using AMCC PPC405EP processor.


Thanks in advance.


Regards,

Darcy
