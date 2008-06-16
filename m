Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22900DDF0D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 04:12:02 +1000 (EST)
Message-ID: <4856ACEA.5050703@freescale.com>
Date: Mon, 16 Jun 2008 13:11:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
References: <788575.91210.qm@web83508.mail.sp1.yahoo.com>
In-Reply-To: <788575.91210.qm@web83508.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> I don't see a "dma" node in the mpc8377mds.dts (2.6.25).  I found one in mpc8610_hpcd.dts and
> modeled it after that.

The DMA hardware on the 8610 is not the same as the DMA hardware on 83xx chips.
 You should copy the DMA data from another 83xx DTS.

-- 
Timur Tabi
Linux kernel developer at Freescale
