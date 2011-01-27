Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CAD6B1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 15:26:00 +1100 (EST)
Subject: Re: 750gx cpufreq induced kernel panic in 2.6.36
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTinS8wJq-wr1=yoeC-f-FcToPzsKLmA3hrshaUms@mail.gmail.com>
References: <AANLkTikJ8V-gQv93HBDH3=4o51vY5xyxQojqEV7DqNj=@mail.gmail.com>
	<1296016338.2349.125.camel@pasglop>
	<AANLkTim7gDwj+xCxiiTka23eu=v7kZX+Pq=3sQ1FT49J@mail.gmail.com>
	<1296078183.2349.141.camel@pasglop>
	<AANLkTinS8wJq-wr1=yoeC-f-FcToPzsKLmA3hrshaUms@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 Jan 2011 15:25:52 +1100
Message-ID: <1296102352.2349.164.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-01-26 at 21:59 -0600, kevin diggs wrote:
> Ok! Thanks!
> 
> One thing. The 2.6 driver for the serial ports on this machine does
> not work very well. Can I use a slower speed to avoid missing stuff?

pmac zilog ? It should work fine on tx... unless your receiving side is
the one with a problem or we have a bug :-)

> And I'll need to build the serial stuff into the kernel, right?

Yes.

Cheers,
Ben.
