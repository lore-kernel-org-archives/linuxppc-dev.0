Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CD3E67A6C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 01:22:30 +1100 (EST)
Date: Thu, 17 Mar 2005 15:20:39 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050317152039.0b9d9fde@jack.colino.net>
In-Reply-To: <1111044955.7192.210.camel@gaston>
References: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
	<20050317075157.19aa4df0@jack.colino.net>
	<1111044955.7192.210.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Make sleep/wakeup work with USB on powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 17 Mar 2005 at 18h03, Benjamin Herrenschmidt wrote:

Hi, 

> > Would it be the "proper" patch I was looking for in the thread named
> > "[PATCH] Re-power USB ports on wakeup" ?
> > 
> > Or does it fix different issues ? Mine fixed, with a hack I think,
> > the fact that USB ports kept being powered down after one wakeup
> > out of two. I never got any machine check, however.
> 
> Test please, your patch shouldn't be necessary.

Just did so, it's not enough. My patch seems necessary so that usb
ports are powered at each wakeup (the second one, that doesn't touch
anything at sleep and sets power unconditionnaly at wakeup, works fine).
With Paul's patch, (dis)connecting USB devices during sleep isn't a
problem anymore.
-- 
Colin
