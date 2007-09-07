Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A855DDF19
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:26:48 +1000 (EST)
Date: Fri, 7 Sep 2007 09:26:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/10] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock
	functions.
Message-ID: <20070907142639.GC14768@ld0162-tx32.am.freescale.net>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192119.GJ32113@ld0162-tx32.am.freescale.net>
	<20070907005357.GI26079@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070907005357.GI26079@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 10:53:57AM +1000, David Gibson wrote:
> Uh... doesn't this need to go in the series *before* the patch that
> uses fsl_get_immr() for the pq2 code..?

Oops, yes.

-Scott
