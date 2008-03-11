Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080310235429.GC11559@localhost.localdomain>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<20080307002730.GB24142@localhost.localdomain>
	<9f7d0248e911f6fa1a2d4292c96ef72e@kernel.crashing.org>
	<20080310235429.GC11559@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a87a2706d92c7d1d873667f4ddc366f0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Tue, 11 Mar 2008 19:43:27 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> This isn't a problem with this device tree, but it's probably time we
>>> started establishing some conventional generic names for nand flash
>>> and board-control devices.
>>>
>>> So, to start the ball rolling, I've seen several names for nand flash
>>> nodes, I'd suggest we standardise on "nand-flash".
>>
>> What's wrong with the already well-established generic name "flash"?
>
> I was concerned that using "flash" for both NOR flash (which it
> already is) and NAND flash might be unwise.  I am quite open to being
> convinced otherwise, though.

You already said you're convinced, but I'll add another argument
anyway...

For NAND flash, there will usually be a parent node named 
"nand-controller"
or similar, while NOR flash will typically be direct-mapped.

There is always this tension between making the names as generic as
possible, and not losing too much information.  In my experience, you
can always make leaf nodes have very very generic names, it's only the
bus nodes where this can be harder.  And then there are exceptions like
"board-control" where there just _is_ no really good name ;-)


Segher
