Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk01.marconi.com (smtpoutuk01.marconi.com
	[128.87.251.112]) by ozlabs.org (Postfix) with ESMTP id 49485683CF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 14:53:37 +1000 (EST)
To: "Vitaly Bordug <vbordug" <vbordug@ru.mvista.com>
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Thu, 6 Oct 2005 12:53:26 +0800
Message-ID: <OFAF025B3B.4E7DEDE8-ON48257092.0018E543@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: "linuxppc-embedded list <linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: kernel.org's kernel: building and root file system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi;
      I am new to this and I have some questions of "what's next?" after
having downloaded the latest kernel from kernel.org:

(1)   Since I am going to build the kernel for PPC platform and
architecture, running `make xconfig` won't bring up the right set of
configurations for your target but the default which is a generic X86
architecture and platform. What is the usual step so that I will have the
configuration set for my target? I think of 2:

      (i) copy arch/ppc/configs/<foo>_defconfig to $SRC_BASE/.config; `make
xconfig`
      (ii) `make xconfig`; and inside the X-window, open the
arch/ppc/configs/<foo>_defconfig and save it for your architecture.

      I tried (ii) but after having opened the <foo>_defconfig, it is not
reflected at all in the X-window. It is still showing the default
configurations.

(2)   Ok, you have the kernel running on your PPC target. How about the
root file system? Where and how can I have/build a generic root file system
that works with kernels running from kernel.org?

(3)   Toolchain. What cross-toolchain is generally used to build the kernel
for your target? For PPC, I come across this
http://penguinppc.org/dev/crosstool.php... Is that popularly used to build
kernel from kernel.org for PPC architecture and platform?

      Thanks for any comment and insight.

Regards,
TEH
