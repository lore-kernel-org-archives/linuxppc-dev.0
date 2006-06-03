Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5C99A67A2E
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 13:28:21 +1000 (EST)
Date: Fri, 2 Jun 2006 22:28:08 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [2.6.18] U4 DART improvements
Message-ID: <20060603032808.GE28528@pb15.lixom.net>
References: <20060602040426.GA28528@pb15.lixom.net>
	<61e1e9d0ada7e9648b8590cfac2b67b9@kernel.crashing.org>
	<1149295238.7972.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149295238.7972.12.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 03, 2006 at 10:40:38AM +1000, Benjamin Herrenschmidt wrote:

> In fact I doubt we need a barrier at all...

Yeah, I'm not sure what I was thinking. There's need for a barrier
before the invalidation to make sure that a stale entry doesn't get
re-entered into the TLB, and it's already done before the call. I have
no good explanation for why I added that one.

I'll respin, test and repost the patch tomorrow.


-Olof
