Return-Path: <osingla@Integrian.com>
Received: from mail.Integrian.com (nsc64.16.143-89.newsouth.net [64.16.143.89])
	by ozlabs.org (Postfix) with ESMTP id 945F067CD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 03:41:31 +1000 (EST)
Message-ID: <42DE89B1.1030400@integrian.com>
Date: Wed, 20 Jul 2005 13:28:17 -0400
From: Olivier Singla <osingla@integrian.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Subject: LITE5200 2.6.x kernel support
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

I am currently using 2.4.25 on the Lite5200 board, but I'd really like to
switch to 2.6.x. The only 5200 specific support I need are the integrated
uart and the PCI. I tried both 2.6.11 and 2.6.12 without luck: the kernel
start, but then is stuck (seems into the init sequence). I use the
configuration
file from arch/ppc/configs/lite5200_defconfig. I cross-compiled the
kernel with gcc-3.4.1.

I was wondering if somebody could give me some help, maybe by telling
be what I am doing wrong.

Thanks,
Olivier

BTW, I tried also 2.6.13-rc3, but I can't even compile for the Lite5200,
there are some syntax error when compile the pci module...
