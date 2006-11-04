Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E32F67C02
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 12:40:29 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA41eLgC002980
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 20:40:21 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA41eKCr294498
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 20:40:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA41eKje011431
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 20:40:20 -0500
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061103174948.34a5afe4@localhost.localdomain>
References: <OFCD6BEB84.DE407CA1-ON8725721B.00508624-8525721B.00552A5F@us.ibm.com>
	<1162586775.10630.92.camel@localhost.localdomain>
	<20061103145300.411931b7@localhost.localdomain>
	<1162589534.10630.127.camel@localhost.localdomain>
	<20061103174948.34a5afe4@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 19:41:13 -0600
Message-Id: <1162604473.23288.14.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-03 at 17:49 -0600, Olof Johansson wrote:
> On Sat, 04 Nov 2006 08:32:14 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > But that's not a public/opensource thing people use regulary is it ?
> 
> Might not be. I don't know what AMCC use for their eval boards, if it's
> u-boot or PIBS or something else.

AMCC uses u-boot on their new boards.  Some of their older ones used
PIBS.

PIBS does have an open source type license.  You can download it as part
of the PPC 970FX eval kit.  Or other eval kits for various boards.

josh
