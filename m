Return-Path: <michaelellerman@internode.on.net>
Received: from mail.internode.on.net (bld-mail07.adl2.internode.on.net
	[203.16.214.71]) by ozlabs.org (Postfix) with ESMTP id 83675679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 09:33:26 +1100 (EST)
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Michael Ellerman <michaelellerman@internode.on.net>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143631816.9481.5.camel@localhost>
References: <1143631816.9481.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 17:28:39 +1100
Message-Id: <1143700119.23392.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-29 at 13:30 +0200, Johannes Berg wrote:
> On a PowerMac11,2, there are two i2c-bus@0 nodes of which only the first
> is correct. This patch makes the device tree unflattening code ignore
> the second one on those machines.
> 
> Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>
> 
> --- 
> I'm not sure this is the right way to do it. Maybe we should have some
> 'dev-tree quirks fixer' that makes a third pass through the device tree
> after the allnodes chain has been set up, and fixes it up. On the other
> hand, as long as there aren't too many workarounds, this works fine.
> 
> The patch looks longer than it is because some code changed indentation
> level.

I don't understand why we need this patch? If we care about getting the
"right" node why not check for that where we care?

cheers

-- 
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person
