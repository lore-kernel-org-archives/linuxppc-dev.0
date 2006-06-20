Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F15F767B29
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 10:00:51 +1000 (EST)
In-Reply-To: <20060619233155.361570@bebe.enoyolf.org>
References: <20060619171943.7730@bebe.enoyolf.org>
	<20060619233155.361570@bebe.enoyolf.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4D16FE8A-739E-4341-9C31-4465CC9E0A38@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OFW node names 
Date: Tue, 20 Jun 2006 02:00:42 +0200
To: Doug Maxey <dwm@maxeymade.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Apple sometimes uses AAPL.  Never seen the ONNNNNN thing.
>
> matches the US stock symbol, goodness.

Yeah.  Wow.  They also use "aapl", of course -- or nothing
at all.  Or "apl" in at least one case.

>>> My view has been limited to the IBM platform.  According to the
>>> examples, this is a recommended practice.  I know IBM uses the
>>> lowercase variant.
>>
>> Which _is_ allowed, although discouraged.
>
> Ok, but who enforces it?  Vendor polices themselves?  Right. :->

If there is a comma, the part before the first comma is supposed
to be a vendor identifier.  The actual format of that is allowed
to be basically anything, even by the OF standard itself.  The
less ambiguous formats are encouraged though...


Segher
