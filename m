Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17D922BEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 17:55:17 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Martin-=C9ric?= Racine <q-funk@iki.fi>
In-Reply-To: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
References: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 23 Dec 2004 07:54:20 +0100
Message-Id: <1103784861.29975.2.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-12-23 at 01:36 +0200, Martin-Éric Racine wrote:
> Nice to know that work is being done on the pmac ALSA driver. :)
> 
> However, I still cannot get ALSA to work at all on this iMac's Burgundy:  
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306
> 
> The old OSS driver still works, so I know that the hardware is not at
> fault; this is clearly an ALSA driver problem.
> 
> Has anybody managed to get this to work on similar hardware?

I don't have any of such hardware, but you are welcome to compare the
drivers and help debug it :)

Ben.
