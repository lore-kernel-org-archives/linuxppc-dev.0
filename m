Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id A106EDDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 22:34:25 +1100 (EST)
Message-ID: <48F727E2.6010704@scram.de>
Date: Thu, 16 Oct 2008 13:39:14 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-cpm: Suppress autoprobing for devices
References: <20081016111300.GC3432@pengutronix.de>
In-Reply-To: <20081016111300.GC3432@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang schrieb:
> Similar to commit 618b26d52843c0f85b8eb143cf2695d7f6fd072d, also remove
> automatic probing for this i2c controller. Might need updates to dts files
> using it.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Jochen Friedrich <jochen@scram.de>
