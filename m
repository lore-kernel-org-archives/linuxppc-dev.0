Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A64ADE0F8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:34:58 +1000 (EST)
Message-ID: <485811DD.50106@freescale.com>
Date: Tue, 17 Jun 2008 14:34:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
	<20080617162309.GA3217@loki.buserror.net>
	<2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>
	<485801A7.3090309@freescale.com>
	<C5C81740-FEF8-42CA-80C2-A729238BED2B@kernel.crashing.org>
In-Reply-To: <C5C81740-FEF8-42CA-80C2-A729238BED2B@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Also, there is a direction that does work.  You can run an e500v2 kernel 
> on an e500mc.  Its just going the other way around that can be an issue.

Actually, wouldn't the kernel need to set HID0[DCBZ32] for an e500v2 
kernel to run on e500mc?

-Scott
