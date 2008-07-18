Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 82230DDEF1
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 03:45:26 +1000 (EST)
In-Reply-To: <20080718034727.GF18748@yookeroo.seuss>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com>
	<20080718034727.GF18748@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fc7a47590d1991616768ecd10cfc032a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Fri, 18 Jul 2008 12:47:08 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2008, at 10:47 PM, David Gibson wrote:

> On Thu, Jul 17, 2008 at 11:14:11AM -0500, Milton Miller wrote:
>> On Thu Jul 17 at 23:22:28 EST in 2008, Guillaume Dargaud wrote:
> [snip]
[more snip]
>> We call this the flattened device tree.
>
> Your firmware doesn't have to deal with this though, although it can.
> It's perfectly acceptable - in fact I'd mildly recommend it over doing
> this in the firmware - to instead have the kernel's zImage wrapper
> supply the flattened device tree, folding information it needs to get
> from the firmware into it.

I thought about adding a section on which to recommend or talk about 
the tradeoffs, but got hungry and hit send before going to lunch.

Yes, I the zImage choice is definitely the least amount of code to 
write, and is a good tradeoff to get future upgradability.  It may not 
be the absolute fastest split of the work to start the kernel but it is 
reasonably good, especially as it will decompress the kernel to its 
run-time destination.

milton
