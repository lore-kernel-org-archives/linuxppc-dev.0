Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DB8EB70B9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 03:54:33 +1000 (EST)
Subject: Re: [PATCH] [v2] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
MIME-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset="iso-8859-1"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4E723B0A.9000802@freescale.com>
Date: Thu, 15 Sep 2011 12:54:19 -0500
Message-ID: <45584309-BA30-4C2A-AF5E-AE22506D705D@freescale.com>
References: <1316036538-311-1-git-send-email-timur@freescale.com>
	<454A6F08-BD85-4C80-BF0D-3BC04D95EA36@freescale.com>,
	<4E722860.8090605@freescale.com>
	<95760360-FBCE-4D68-B2AB-A5270F8FBD0F@freescale.com>
	<4E723B0A.9000802@freescale.com>
To: Timur Tabi <b04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2011, at 12:51 PM, Timur Tabi wrote:

> Gala Kumar-B11780 wrote:
>> I pulling the p3060qds bit out so drop that change from next patch.
>> 
> 
> Ok, I'm thinking it should look like this:
> 
> 	compatible = "fsl,p3060qds-fpga", "fsl,fpga-qixis";

Right, I pulled those bits out of your patch.

- k
