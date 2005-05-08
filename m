Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7A98679E9
	for <linuxppc-dev@ozlabs.org>; Sun,  8 May 2005 19:39:41 +1000 (EST)
Date: Sun, 8 May 2005 11:39:25 +0200
From: Colin Leroy <colin@colino.net>
To: John Steele Scott <toojays@toojays.net>
Message-ID: <20050508113925.36f9989f@jack.colino.net>
In-Reply-To: <87k6mamj6o.fsf@toojays.net>
References: <1115072133.6031.33.camel@gaston>
	<20050503083728.3bedc3ef@colin.toulouse>
	<1115164256.7627.57.camel@gaston>
	<20050507140644.5919b4c3@jack.colino.net>
	<87k6mamj6o.fsf@toojays.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 08 May 2005 at 14h05, John Steele Scott wrote:

Hi, 

> I finally tried this today, using 2.6.12-rc4, which has this patch.
> Without USB devices attached, it's okay, but with my USB hub
> attached, I get a (reproducable) panic in echi_hcd on the way to
> sleep.
> 
> I took a photo of the panic and enhanced it for readability, it's at
> <http://www.toojays.net/portal/Members/toojays/ibook-g4-sleep-crash-2.6.12-rc4.jpg>.

linux-usb-devel may be interested. (I don't have an usb hub so can't
test it)

-- 
Colin
