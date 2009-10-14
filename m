Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77A68B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 02:27:28 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9EFROvp020145 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 08:27:24 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9EFUO7l016401
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 10:30:24 -0500 (CDT)
Date: Wed, 14 Oct 2009 10:27:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: Richard Cochran <richard.cochran@omicron.at>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <20091014152722.GA17867@b07421-ec1.am.freescale.net>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
	'Roland Lezuo' <roland.lezuo@chello.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2009 at 09:41:33AM +0200, Richard Cochran wrote:
> >-----Original Message-----
> >From: linuxppc-dev-bounces On Behalf Of Scott Wood
> >Sent: Wednesday, September 09, 2009 8:22 PM
> >To: Roland Lezuo
> >Cc: linuxppc-dev@lists.ozlabs.org
> >Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
> >
> >On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
> >> The following patch is needed to correctly assign the IRQs for the
> >> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
> >> as well as the interrupt lines for the two devices.
> >
> >And it will incorrectly assign them on older revisions of the chip.
> >
> >We really should have a u-boot fixup based on SVR.
> 
> Why not just offer different dts files, one for each board revision?
> 
> Something like:
> mpc8313erdb-revA.dts
> mpc8313erdb-revB.dts
> mpc8313erdb-revC.dts

Because that would be three times the device trees to maintain, and a
source of user confusion.

-Scott
