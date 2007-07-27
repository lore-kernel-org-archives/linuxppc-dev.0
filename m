Return-Path: <pacman@shell01.TheWorld.com>
Received: from TheWorld.com (pcls5.std.com [192.74.137.145])
	by ozlabs.org (Postfix) with ESMTP id 389F4DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 14:48:13 +1000 (EST)
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200707270448.l6R4m1O31531714@shell01.TheWorld.com>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
To: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 27 Jul 2007 00:48:01 -0400 (EDT)
In-Reply-To: <20070726212241.032e9755.akpm@linux-foundation.org> from "Andrew
	Morton" at Jul 26, 2007 09:22:41 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes the following:
>> > 
>> > Did this get merged, or otherwise fixed?  Even though the code in there has
>> > changed quite a bit, it looks to my untrained eye like the fix is still
>> > applicable?
>> 
>> Merged a fixed version:
>> 
>> f5d834fc34e61f1a40435981062000e5d2b2baa8
>> 
>> (In linus tree as of now)
>
>I hope so.  Alan's patch looks rather different from what you have now:
>fall back to of_find_node_by_name() if of_find_node_by_type() failed.
>

Looking at it via gitweb, I think the commit mentioned above is actually the
same as what I submitted. The diff context lines are different because there
was a similar patch in between the 2.6.22 release and my patch, which
apparently fixed the same problem on a different type of machine. It looks
like these 2 workarounds will function independently of each other.

The first 8042-detection fix was:
db0dbae9d9680bce69fe1ce775709e60c8ee9c29

And mine is:
f5d834fc34e61f1a40435981062000e5d2b2baa8

-- 
Alan Curry
pacman@world.std.com
