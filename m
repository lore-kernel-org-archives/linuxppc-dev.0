Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34D2BDDF28
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:47:44 +1000 (EST)
Date: Mon, 15 Oct 2007 13:47:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
Message-ID: <20071015184743.GA4474@loki.buserror.net>
References: <20071015153525.GA28761@localhost.localdomain>
	<47138A54.8030307@ru.mvista.com>
	<20071015155730.GA30008@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071015155730.GA30008@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 07:57:30PM +0400, Anton Vorontsov wrote:
> On Mon, Oct 15, 2007 at 07:42:12PM +0400, Sergei Shtylyov wrote:
> >    Is the entity described as "localbus" indeed so *board* specific?
> 
> That's what booting-without-of.txt gives as an example.

The board should have been left out of that.  Your compatible should be
something like "fsl,mpc8568-localbus", possibly with some canonical mpc85xx
chip as well, chosen to represent 85xx localbus in general.

-Scott
