Return-Path: <corsac@corsac.net>
Received: from heracles.corsac.net (heracles.corsac.net [82.224.202.188])
	by ozlabs.org (Postfix) with ESMTP id 1F79367A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 01:48:52 +1000 (EST)
Received: from localhost (heracles [127.0.0.1])
	by heracles.corsac.net (Postfix) with ESMTP id 04FB3150102
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:27:18 +0200 (CEST)
Received: from heracles.corsac.net ([127.0.0.1])
	by localhost (heracles.corsac.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30259-05 for <linuxppc-dev@ozlabs.org>;
	Tue, 29 Aug 2006 17:27:11 +0200 (CEST)
Received: from [IPv6?2001?7a8?78df?1?211?24ff?fe96?be70] (unknown
	[IPv6:2001:7a8:78df:1:211:24ff:fe96:be70])
	by heracles.corsac.net (Postfix) with ESMTP id 4DC4C1500D4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:27:11 +0200 (CEST)
Subject: Re: Linux v2.6.18-rc5
From: Yves-Alexis Perez <corsac@corsac.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20060829130629.GW11309@localdomain>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060829115537.GA24256@aepfle.de> <20060829130629.GW11309@localdomain>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 17:26:32 +0200
Message-Id: <1156865192.2719.8.camel@hidalgo>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-29 at 08:06 -0500, Nathan Lynch wrote:
> Sorry about that, does this (a partial revert of the change) fix it
> for you? 

I tried 2.6.18-rc5 on my powerbook g4 (5,6) and indeed I had lots of
deadlocks, it was quite unusable. I've tried this patch and it seems to
fix the problem. (up for half an our without problems, I guess)
-- 
Yves-Alexis
