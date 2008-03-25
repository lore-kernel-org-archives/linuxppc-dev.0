Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7677EDDEE4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 01:36:27 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m2PEaLoa017973
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 07:36:21 -0700 (MST)
Date: Tue, 25 Mar 2008 09:36:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Simplify error handling for unparseable input
Message-ID: <20080325143619.GB13187@ld0162-tx32.am.freescale.net>
References: <20080324034424.GC29985@localhost.localdomain>
	<20080324173641.GA22159@loki.buserror.net>
	<20080325012805.GA1227@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080325012805.GA1227@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 12:28:05PM +1100, David Gibson wrote:
> On Mon, Mar 24, 2008 at 12:36:41PM -0500, Scott Wood wrote:
> > If you remove this, there'll be no way to indicate semantic errors other
> > than die() (the NULL approaches are no good, since they inhibit recovery),
> > which is suboptimal if the error is not immediately fatal.
> 
> But everything is immediately fatal.  When we have a *real* example of
> something that's not, we can restore an error code.

Failed binary includes are not immediately fatal.

-Scott
