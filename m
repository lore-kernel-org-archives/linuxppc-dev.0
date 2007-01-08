Return-Path: <SRS0+df5a3e86c510a22e5b24+1233+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BE15DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 13:17:43 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: David Woodhouse <dwmw2@infradead.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45A1535C.1080007@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 10:17:33 +0800
Message-Id: <1168222654.14763.92.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-01-07 at 20:09 +0000, Matt Sealey wrote:
> I would expect that it is so much easier, even if it does not strike
> you as too "clean", to forget about naming compatibility nodes here,
> and concentrate on the real showstoppers. I would consider the AC97
> PSC not being set up, the IrDA PSC not being set up, the disk
> numbering and any problems we're having with USB devices (argh) to
> be real showstoppers. 

I'm inclined to agree. What I said was "since they have showstopper bugs
to fix, we might as well let them fix the less important device-tree
stuff at the same time."

Please can we have a firmware with the important stuff fixed, and
preferably the simple and uncontentious device-tree fixes too; like
perhaps no longer pretending to be CHRP?

The other device-tree stuff you're arguing about is less important,
because it isn't _that_ hard to fix it up in prom_init() -- although it
would have been nice if the debate had happened when people were trying
to put the spec together in the first place, rather than only now.

-- 
dwmw2
