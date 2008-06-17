Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97F0BDE3D3
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 04:26:10 +1000 (EST)
Message-ID: <485801A7.3090309@freescale.com>
Date: Tue, 17 Jun 2008 13:25:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
	<20080617162309.GA3217@loki.buserror.net>
	<2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>
In-Reply-To: <2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>
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
> On Jun 17, 2008, at 11:23 AM, Scott Wood wrote:
>> We should probably depend on !PPC_85xx until we can support such a
>> configuration, rather than have it break in less obvious ways.
> 
> I don't see any reason for this.  While our marketing may say its not an 
> 85xx anymore its pretty close to one.  For example I plan on the board 
> code living in platforms/85xx.

The reason is that if we can't build both into the same kernel, the 
kconfig shouldn't pretend that we can.

-Scott
