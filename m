Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D22C2BEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 19:01:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dean Hamstead <dean@bong.com.au>
In-Reply-To: <41CA0E0D.908@bong.com.au>
References: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
	<41CA0E0D.908@bong.com.au>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 09:00:47 +0100
Message-Id: <1103788847.29975.10.camel@gaston>
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

On Thu, 2004-12-23 at 11:15 +1100, Dean Hamstead wrote:
> the pmac driver has issues on my imac dv, it works but alas
> it doesnt know what to do when plugging in headphones
> not to mention lack of input sensors for my ibook (clamshell)
> 
> i realise though that if you cant get specs and no one
> wants to tinker around stuff wont get implemented.
> but if its in OSS...

Well, there are specs: the Darwin sources are available for all of Apple
sound drivers. It's just that there are approx. as many HW setups as
motherboards, so it's a bit of a mess, and I don't have much time to dig
into it (and I didn't write the Alsa driver).

But others are welcome to work on it & propose patches :)

Ben.
