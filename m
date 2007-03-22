Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 214D6DDF3C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:24:18 +1100 (EST)
In-Reply-To: <20070322020925.GA13114@lixom.net>
References: <20070322020925.GA13114@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8f820a3c81d934b09c621e9fe55dd248@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Use mtocrf in asm when CONFIG_POWER4_ONLY=y
Date: Thu, 22 Mar 2007 12:24:09 +0100
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> mtocrf is a faster single-entry mtcrf available in PPC 2.00 and later
> processors. It can make quite a difference in performance on some
> implementations, so use it for CONFIG_POWER4_ONLY=y builds.

Does anyone know which CPUs that don't implement mtocrf
don't treat it identical to mtcrf?  That would allow to
widen when we use mtocrf.  Or perhaps it's really time
for an "asm alternatives" run-time patch thing now :-)

Patch looks good as-is but I can always ask for more...


Segher
