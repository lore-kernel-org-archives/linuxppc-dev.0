Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D33A1007D7
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 14:22:28 +1000 (EST)
Date: Thu, 19 May 2011 00:16:06 -0400 (EDT)
Message-Id: <20110519.001606.676062526002188941.davem@davemloft.net>
To: torvalds@linux-foundation.org
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: David Miller <davem@davemloft.net>
In-Reply-To: <BANLkTikRjqpxRKKhawcD1WjyhmH1PUgz5A@mail.gmail.com>
References: <1305777978.7481.37.camel@pasglop>
	<BANLkTikRjqpxRKKhawcD1WjyhmH1PUgz5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 May 2011 21:11:47 -0700

> On Wed, May 18, 2011 at 9:06 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>>
>> Dunno if it's too late or not yet but here's 3 fixes for powerpc that
>> would be welcome to have in before the release. If not I'll send them
>> first thing next (one of them is already in -next in fact).
> 
> Gah. I just cut 2.6.39.

I know we can't let these things go forever, but in my opinion
we should have given this one or two more -rc's.
