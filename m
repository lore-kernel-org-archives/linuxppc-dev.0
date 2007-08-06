Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1186154678.9004.22.camel@ld0161-tx32>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070628100020.GA24215@iram.es>
	<20070803063532.GB14456@localhost.localdomain>
	<1186154678.9004.22.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b2fbd55160457499993f42a04031af29@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Mon, 6 Aug 2007 21:43:43 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +		MPIC: interrupt-controller@d {
>>>> +			device_type = "open-pic";
>>>>
>>>> device_type = "interrupt-controller".
>>
>> Not according to the binding in booting-without-of.txt
>
> My understanding here, though possibly flawed, is that the current
> implementation has "open-pic" but _should_ have "interrupt-controller"
> as that is the officially correct name.
>
> I _think_ this means we need a transitional period where we update
> the code to look for "interrupt-controller", and obsoletedly, looks
> for the "open-pic", while we transition to the new, correct name.
>
> I'm just betting that if I'm wrong Segher will tell me! :-)

You're wrong :-)

The kernel shouldn't look at device_type at all.


Segher
