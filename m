Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 773FCDDFEE
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 05:42:10 +1100 (EST)
Message-ID: <497A0F78.8000600@freescale.com>
Date: Fri, 23 Jan 2009 12:42:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Johns Daniel <johns.daniel@gmail.com>
Subject: Re: Common kernel image for e300 and e500v2
References: <ba5d9360901230705v750a958au7eeaa923aadc41ad@mail.gmail.com>	<4979EE74.6040306@freescale.com>
	<ba5d9360901230931o20611d59hafdfb555209e255c@mail.gmail.com>
In-Reply-To: <ba5d9360901230931o20611d59hafdfb555209e255c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johns Daniel wrote:
> Thank you for that piece of info, Scott!
> 
> May I expand the question one bit, and ask whether the user-mode 
> binaries compiled for the e300 will generally work for the e500 -- or, 
> vice versa? Is one choice safer than the other?
> 
> I know for sure that we take a big hit on floating-point ops, but are 
> there other things I am not considering?

It should work, though as you note floating point will have to be 
emulated (make sure your kernel supports it); better would be to compile 
as soft-float.  Also avoid string instructions.

-Scott
