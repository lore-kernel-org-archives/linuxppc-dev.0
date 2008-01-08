Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2AFC7DDF26
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:41:45 +1100 (EST)
Message-ID: <4783C3E8.3090107@pikatech.com>
Date: Tue, 08 Jan 2008 13:41:44 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Miscellaneous for Taco
References: <477F13C0.7040006@pikatech.com> <1199517865.7291.50.camel@pasglop>
	<200801051026.26870.sr@denx.de> <477FCADA.2010706@pikatech.com>
	<1199566583.7291.63.camel@pasglop>
In-Reply-To: <1199566583.7291.63.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

How about just 44x?

Cheers,
    Sean

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7580aa5..682deae 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
        # PPC:
        default y if STB03xxx
        default y if PPC_MPC52xx
+       default y if 44x
        # MIPS:
        default y if SOC_AU1X00
        # more:
