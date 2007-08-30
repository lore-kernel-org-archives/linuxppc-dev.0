Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B83FEDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 00:21:28 +1000 (EST)
Date: Thu, 30 Aug 2007 09:21:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/9] bootwrapper: Add a zImage.bin.<platform> target.
Message-ID: <20070830142115.GB24123@ld0162-tx32.am.freescale.net>
References: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
	<20070829164741.GD31640@ld0162-tx32.am.freescale.net>
	<20070830003409.GE21072@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830003409.GE21072@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 10:34:09AM +1000, David Gibson wrote:
> Hrm.. I think the --binary option at least should be removed, and
> subsumed into the platform id - all other binary formats are selected
> by the platform name at present.
> 
> And I think it's probably best to do that for --fixed-entry as well,
> although it's a bit less clear there.

I'm not particularly fond of having huge platform switch blocks in the
wrapper script -- if it can be reasonably parameterized, why not do so?

-Scott
