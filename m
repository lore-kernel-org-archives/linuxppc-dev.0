Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id AEEED67B52
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 02:30:45 +1000 (EST)
In-Reply-To: <20060803135440.GB3075@smtp.west.cox.net>
References: <3115459755319495cff4.1649760492.miltonm@bga.com>
	<20060803135440.GB3075@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <438c15c2cff5b1bfd7f2585f97b4011d@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: RFC: Location for Device Tree Sources?
Date: Thu, 3 Aug 2006 11:30:41 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 3, 2006, at 8:54 AM, Tom Rini wrote:
> On Thu, Aug 03, 2006 at 04:32:33AM -0500, Milton Miller wrote:
>> I don't think we need to bump the dt version every time we make a tree
>> content requirements change.  We need to bump when we add or
>> change fields in the struct header, change internal layout, or change 
>> how
>> we pass  information through the tree.  Certianly not because someone
>> left things out of their tree.
>
> But "content requirements change" isn't the same as "left things out of
> their tree".  It sounds, and I haven't seen the changes, so I'm not
> certain that the meaning behind a field changed.  Something like that
> should change the dt version.  New fields aren't a problem.  Changing
> existing fields meaning in incompatible ways is a problem.
>

Agreed.   I too haven't looked at the change, but thought it was the
former.
