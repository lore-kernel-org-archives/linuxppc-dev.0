Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8353B70B2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 03:51:12 +1000 (EST)
Message-ID: <4E723B0A.9000802@freescale.com>
Date: Thu, 15 Sep 2011 12:51:06 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] [v2] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
References: <1316036538-311-1-git-send-email-timur@freescale.com>
	<454A6F08-BD85-4C80-BF0D-3BC04D95EA36@freescale.com>,
	<4E722860.8090605@freescale.com>
	<95760360-FBCE-4D68-B2AB-A5270F8FBD0F@freescale.com>
In-Reply-To: <95760360-FBCE-4D68-B2AB-A5270F8FBD0F@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gala Kumar-B11780 wrote:
> I pulling the p3060qds bit out so drop that change from next patch.
> 

Ok, I'm thinking it should look like this:

	compatible = "fsl,p3060qds-fpga", "fsl,fpga-qixis";

-- 
Timur Tabi
Linux kernel developer at Freescale
