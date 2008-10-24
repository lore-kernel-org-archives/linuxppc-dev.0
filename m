Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Oct 2008 15:45:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024044511.GI4267@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49014C69.8020408@firmworks.com>
Cc: devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 06:17:45PM -1000, Mitch Bradley wrote:
>>
>> No, no, no, no, no.  Making complex multi-level representations of
>> nested things for gpios is just insanity. 
>
>
> You know, I don't find this "argument" particularly compelling.  But it  
> certainly is strongly worded.
>
>>  Just use the same encoded
>> format as we already use for gpio descriptors in 'gpios' properties
>> (which is gpio controller specific, with length defined by
>> #gpio-cells).
>
> http://en.wikipedia.org/wiki/Proof_by_assertion

Don't be patronising.

There is an existing address space defined by the gpio binding.
Defining another one is pointless redundancy.  This is standard good
ideas in computer science, no further argument necessary.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
