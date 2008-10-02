Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6389EDE313
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 05:44:35 +1000 (EST)
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
From: Jon Loeliger <jdl@freescale.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
In-Reply-To: <200810022108.44690.niklaus.giger@member.fsf.org>
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<200810020712.15088.niklaus.giger@member.fsf.org>
	<20081002064156.GS25598@yookeroo.seuss>
	<200810022108.44690.niklaus.giger@member.fsf.org>
Content-Type: text/plain
Date: Thu, 02 Oct 2008 14:37:00 -0500
Message-Id: <1222976220.9242.16.camel@ld0161-tx32>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-02 at 21:08 +0200, Niklaus Giger wrote:

> > > convert-dtsv0 is a small utility program which converts (DTS)
> > > Device Tree Source from the obsolete version 0 to version 1. Version 1
> > > DTS files are marked by line "/dts-v1/;" at the top of the file.
> >
> > Add this remark where, though?
> Add a small chapter IV Utilities in your Documentation/manual.txt.

Patches welcome, of course. :-)

> And if the http://www.jdl.com/git_repos/ would work again, I think the spiders 
> would pick it up from there.


I fetched http://www.jdl.com/software/dtc.git through
my firewall at work just this morning.  What problem
are you seeing?  Are you unable to clone
git://git.jdl.com/software/dtc/git ?

jdl
