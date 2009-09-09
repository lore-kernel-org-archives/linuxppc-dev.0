Return-Path: <Kim.Phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C8026B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 06:35:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n89KZ6fT002966 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 13:35:06 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n89Kajcq027867
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Sep 2009 15:36:45 -0500 (CDT)
Date: Wed, 9 Sep 2009 15:35:05 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-Id: <20090909153505.9854c93d.kim.phillips@freescale.com>
In-Reply-To: <F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Roland Lezuo <roland.lezuo@chello.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Sep 2009 15:28:01 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 9, 2009, at 1:22 PM, Scott Wood wrote:
> 
> > On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
> >> The following patch is needed to correctly assign the IRQs for the
> >> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
> >> as well as the interrupt lines for the two devices.
> >
> > And it will incorrectly assign them on older revisions of the chip.
> >
> > We really should have a u-boot fixup based on SVR.

definitely.

> I felt like Kim did this.

I never got my hands on a Rev. C board.  What's the SVR on it?  I think
this is also valid for Rev. B boards, and I don't have one of those
either.

Kim
