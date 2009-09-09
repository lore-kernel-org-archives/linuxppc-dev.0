Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A87EFB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 04:22:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n89IMSXv011015 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 11:22:29 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n89IO7s7021536
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 13:24:08 -0500 (CDT)
Date: Wed, 9 Sep 2009 13:22:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roland Lezuo <roland.lezuo@chello.at>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <20090909182227.GA8215@b07421-ec1.am.freescale.net>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
> The following patch is needed to correctly assign the IRQs for the
> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
> as well as the interrupt lines for the two devices.

And it will incorrectly assign them on older revisions of the chip.

We really should have a u-boot fixup based on SVR.

-Scott
