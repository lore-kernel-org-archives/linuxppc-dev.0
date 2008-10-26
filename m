Return-Path: <dgibson@ozlabs.org>
Date: Mon, 27 Oct 2008 10:47:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081026234747.GD22339@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <490248C2.9020104@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 05:14:26PM -0500, Matt Sealey wrote:
>
>
> David Gibson wrote:
>> Don't be patronising.
>>
>> There is an existing address space defined by the gpio binding.
>> Defining another one is pointless redundancy.  This is standard good
>> ideas in computer science, no further argument necessary.
>
> The existing address space, and the patches Anton etc. just submitted
> which I started this discussion to address, don't fulfil certain
> needs.

Such as what?  Apparently none, since elsewhere in this thread you
seem to be happy with the suggestion of using a gpio-header node,
which does use the same address space.

> You could do better than call it insane, by describing how you would
> define a gpio bank that used 3 seperate pins which are NOT together
> in a register, using a base address (reg) and base property (offset
> of first pin) with the current system?

Um.. I can't actually follow what you're getting at there, sorry.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
