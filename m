Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3178DDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 19:04:24 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q94ICk310864
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 09:04:18 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q94II22326738
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:04:18 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q94HKG024218
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:04:18 +0200
In-Reply-To: <200709251629.52376.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] ibmebus: Remove bus match/probe/remove functions
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF75EB1622.74703D5A-ONC1257362.003152BE-C1257362.0031D489@de.ibm.com>
Date: Wed, 26 Sep 2007 11:04:16 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote on 25.09.2007 16:29:51:

> The description makes it sound like a git-bisect would get broken
> by this patch, which should never happen. If the patch indeed
> ends up with a broken kernel, it would be better to merge it with
> the later patch that fixes the code again.

I took extra care to prevent just that from happening. ibmebus will simply 
be disabled during the transition (because of {un,}register_driver being 
empty dummies), but the kernel builds and boots without problems. So 
unless you're trying to find an ibmebus-based problem, git bisect will be 
fine. I'll repost 2/5 with an updated description.

I split the ibmebus rework into three patches because the merged patch was 
impossible to read. Makes reviewing easier.

Joachim
