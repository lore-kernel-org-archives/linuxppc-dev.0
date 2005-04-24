Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E02B067A6C
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 02:25:10 +1000 (EST)
Date: Sun, 24 Apr 2005 18:24:56 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050424182456.34e92bd2@jack.colino.net>
In-Reply-To: <1114129034.18680.34.camel@gaston>
References: <20050421200408.5361a5b3@jack.colino.net>
	<1114129034.18680.34.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc3] pmac: save master volume on sleep
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 22 Apr 2005 at 10h04, Benjamin Herrenschmidt wrote:

Hi, 

> > Hi,
> > 
> > Ben's patch that shutdowns master switch and restores it after
> > resume ("pmac: Improve sleep code of tumbler driver") isn't enough
> > here on an iBook (snapper chip).
> > 
> > The master switch is correctly saved and restored, but somehow
> > tumbler_put_master_volume() gets called just after
> > tumbler_set_master_volume() and sets mix->master_vol[*] to 0. So, on
> > resuming, the master switch is reenabled, but the volume is set to
> > 0.
> > 
> > Here's a patch that also saves and restores master_vol.
> > Thanks,
> 
> Looks good.

Takashi: any news or comments on this?

Thanks,
-- 
Colin
