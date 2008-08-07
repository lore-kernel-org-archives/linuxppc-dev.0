Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8BCCFDDF30
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 13:18:10 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m773I3xO018455
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 20:18:04 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m773I1tm011082
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 22:18:02 -0500 (CDT)
Subject: Re: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080806172920.GC3138@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
	<20080806172920.GC3138@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 11:32:55 +0800
Message-Id: <1218079975.29628.2.camel@Gundam>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 12:29 -0500, Scott Wood wrote:
> On Wed, Aug 06, 2008 at 03:04:44PM +0800, Li Yang wrote:
> >  		usb@6c0 {
> > -			compatible = "qe_udc";
> > +			compatible = "fsl,qe_udc";
> [snip]
> > +
> > +		np = of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
> > +		if (np) {
> > +			par_io_of_config(np);
> > +			qe_usb_clock_set(np);
> > +		}
> 
> What about existing device trees in use?

This node was never used in existing device trees for mainline kernel.

- Leo
