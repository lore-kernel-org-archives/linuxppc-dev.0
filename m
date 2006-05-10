Return-Path: <chris@netzfragmente.de>
Received: from mail.netzfragmente.de (netzfragmente.de [85.10.199.130])
	by ozlabs.org (Postfix) with ESMTP id 0F37F679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 07:15:02 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Christoph Cebulla <chris@netzfragmente.de>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060510172443.GF3878@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510172443.GF3878@localhost>
Content-Type: text/plain
Date: Wed, 10 May 2006 22:54:33 +0200
Message-Id: <1147294473.20771.11.camel@turing>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> > Did it ever work? 

Kind of... with a patch[1] originally by Ben Collins and adapted by
Gaudenz Steinlin it at least lets you play your favorite music. The
kernel I use is a 2.6.17-rc3-git5.

> Not with Debian, but with this Ubuntu live CD I have sound: 
> Ubuntu 6.06 "Dapper Drake" Beta 2 powerpc (20060427)
> 
> The kernel on their CD is a 2.6.15-21-powerpc

This patch applied cleanly on every kernel I tried since 2.6.15...

> 5.8 is, IINM, the last PPC 15" Powerbook that Apple made
> 
> > Also, try snd-aoa.

Best regards,
Christoph


[1] http://lists.debian.org/debian-powerpc/2006/03/msg00226.html
