Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 540C8DE24A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 03:59:02 +1000 (EST)
Date: Tue, 24 Jun 2008 12:58:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: jumpingProgrammer <rabbitzp@163.com>
Subject: Re: a question of mpc8313, maybe simple
Message-ID: <20080624175822.GA7804@loki.buserror.net>
References: <18067094.post@talk.nabble.com>
	<20080623170956.GA6978@loki.buserror.net>
	<18081728.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18081728.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 06:13:41PM -0700, jumpingProgrammer wrote:
> 
> Thanks a lot for answer my question.
> But i am newhand and not very clear about it.
> Do you mean:
> 1. in this case i do not need to include DMA when i "make menuconfig" ?
>         The path is Device Drivers->DMA.

Right, that's for independent DMA engines, such as for offloading
memory-to-memory copies.

> 2. in this case i do not need add any DMA information in mpc8313erdb.dts?

Right.

-Scott
