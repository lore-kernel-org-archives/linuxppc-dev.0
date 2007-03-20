Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82725DDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 02:50:55 +1100 (EST)
In-Reply-To: <boot-02.miltonm@bga.com>
References: <boot-02.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6a0985482113b033c4acec5cddb1789c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/7] boot: rebuild when wrapper changes
Date: Tue, 20 Mar 2007 16:50:46 +0100
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since there is magic defined per platform in the wrapper script, the
> zImage targets should depend on it.

Thank you, I've been bitten by this before but didn't see
an easy fix.  It's so obvious though :-)

> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
