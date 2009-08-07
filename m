Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CF6C1B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:38:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n77JbksO022039 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 12:37:57 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n77JcJeO029556
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 14:38:20 -0500 (CDT)
Date: Fri, 7 Aug 2009 14:37:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: HongWoo Lee <hongwoo7@gmail.com>
Subject: Re: Question about powerpc branch instructions
Message-ID: <20090807193745.GA11681@b07421-ec1.am.freescale.net>
References: <4A7BEA04.7030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A7BEA04.7030006@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 05:47:00PM +0900, HongWoo Lee wrote:
> #2: Is b similar to the jmp in x86 ? 

Yes, specifically a relative near jmp.

> and bl is similar to the call in x86 ?

Sort of (and again, specifically a relative near call).  Call on x86
pushes the return address on the stack, while bl on powerpc puts the
return address in a special register (lr) that the called function has to
save on the stack itself if it wants to call another function.

-Scott
