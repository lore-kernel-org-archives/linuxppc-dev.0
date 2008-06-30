Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EC81DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 05:56:40 +1000 (EST)
Message-ID: <48693A4E.20704@freescale.com>
Date: Mon, 30 Jun 2008 14:55:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
	<E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
	<Pine.LNX.4.64.0806271609540.10625@blarg.am.freescale.net>
	<20080630041525.GD24012@yookeroo.seuss>
	<20080630153513.GD13950@loki.buserror.net>
	<D70C5CB6-5066-4AD3-9367-879AF39FB8E1@kernel.crashing.org>
In-Reply-To: <D70C5CB6-5066-4AD3-9367-879AF39FB8E1@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I believe this comes into play when we have more than one DMA controller 
> and sometimes there are special uses like on 8610.

Maybe, though I'd just use a phandle to express that (unless you need to 
program the number that you're using, rather than just use a specific one).

Could you add cell-index to the individual channels, though (you have it 
in some dts files, and not others)?

-Scott
