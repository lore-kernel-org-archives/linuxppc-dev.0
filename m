Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 305BCDDF46
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 03:21:18 +1100 (EST)
Message-ID: <4979EE74.6040306@freescale.com>
Date: Fri, 23 Jan 2009 10:21:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Johns Daniel <johns.daniel@gmail.com>
Subject: Re: Common kernel image for e300 and e500v2
References: <ba5d9360901230705v750a958au7eeaa923aadc41ad@mail.gmail.com>
In-Reply-To: <ba5d9360901230705v750a958au7eeaa923aadc41ad@mail.gmail.com>
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
> Is it possible -- and prudent -- to use a single kernel binary image
> for two similar boards, one based on an e300 core and the other on an
> e500v2 core?

No, it is not possible.  They use different MMUs, and the kernel does 
not support choosing between them at runtime.

> I was surprised to see that the e500v2-targeted toolchain did build
> the kernel for the e300 board just fine. Don't know whether this will
> always be true?

"always" is a strong word, but it should generally work.

-Scott
