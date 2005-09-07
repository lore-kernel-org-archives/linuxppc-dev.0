Return-Path: <broonie@projectcolo.org.uk>
Received: from kerouac.projectcolo.org.uk (kerouac.projectcolo.org.uk
	[80.71.3.114])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "kerouac.projectcolo.org.uk",
	Issuer "projectcolo.org.uk CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 07C6E681DC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 02:58:30 +1000 (EST)
Date: Wed, 7 Sep 2005 17:58:26 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050907165825.GB8522@projectcolo.org.uk>
References: <20050831122556.GA474@projectcolo.org.uk>
	<20050907163428.GA8522@projectcolo.org.uk>
	<431F187E.4070006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <431F187E.4070006@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform devices on MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 07, 2005 at 08:42:38PM +0400, Vitaly Bordug wrote:

> Yes, that's right. The proper solution (I guess) will be reconfiguration 
>  in  mpc10x_bridge_init() so that memory covered by the bridge do not 
> intercept anything what pdevs request. Or (less probably) there's 
> something odd in pdevs descriptions - if so you need to find out what 
> exactly is intercepted with the bridge area.

Setting the parent for the on-chip devices to be the PCI bridge ought to
do the trick, I think.  The thing that's worrying me is that I can't see
how existing users of this code manage to do so successfully.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
