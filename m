Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C81E2B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 03:27:26 +1100 (EST)
Date: Thu, 15 Oct 2009 11:27:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Richard Cochran <richard.cochran@omicron.at>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <20091015162728.GB3730@loki.buserror.net>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2009 at 02:19:30PM +0200, Richard Cochran wrote:
> >-----Original Message----- From: Scott Wood [mailto:scottwood@freescale.com]
> >Because that would be three times the device trees to maintain, and a
> >source of user confusion.
> 
> I wonder which is more confusing for the user:
> 
> 1. Choosing one of three dts files.

Possibly incorrectly.

> 2. Having only one dts for his board, but Ethernet doesn't work.

The point is to fix u-boot so that it *does* work with only one dts.  If
people not upgrading u-boot is your concern, we could put the fixup in the
Linux platform code instead.

And feel free to ask through official Freescale support channels why the
U-Boot that shipped on these boards does not have such a fixup (or why they
decided it was better to make late-rev 8313's interrupt assignments match
other 83xx than for all revs of the same part number to have the same
interrupt assignments).

-Scott
