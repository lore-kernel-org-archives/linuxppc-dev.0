Return-Path: <richard@imendio.com>
Received: from holken.mikan.net (holken.mikan.net [195.43.255.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E812BDF2
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2004 23:36:14 +1100 (EST)
Message-ID: <41A9C00A.8090004@imendio.com>
Date: Sun, 28 Nov 2004 13:09:46 +0100
From: Richard Hult <richard@imendio.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1101280145.4511.4.camel@gaston>
In-Reply-To: <1101280145.4511.4.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, gentoo-ppc-user@gentoo.org,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Ok, here's the 5th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.

This seems to be working pretty well, thanks!

One slight problem is that there is some flicker when going to and from 
level 0 on the backlight is still present. I can reproduce this by 
running fblevel 0, with the effect that the backlight temporarily 
switches to the maximum value (it seems) and then shuts it off 
completely. The same happens when going from 0 to a higher value.

The only other problem I've seen is that the trackpad/fn keys settings 
aren't always restored on resume.

Thanks again,
Richard

-- 
Imendio AB, http://www.imendio.com/
