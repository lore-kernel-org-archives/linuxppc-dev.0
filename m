Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070801054751.GM31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <59e87834966d80bb143e1683fe751cd1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 21:59:24 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Yeah, better names please -- if possible, something that someone
>>> without knowledge of this SoC will understand what it is.
>>
>> I think the names are probably ok - I'm assuming they're in keeping
>> with the convention I've used of using the same names / abbreviations
>> as in the CPU user manual.  I'm asking just for my own information,
>> although a comment might not be a bad idea.

Fine with me -- I personally prefer "system-device-controller"
and "clock-power-controller" or similar, but that is mostly a
matter of taste.  As long as it's human readable it's fine.

> -    Required properties:
> +     - compatible : should contain the specific model of flash 
> chip(s) used

"if known".

> +       followed by either "cfi-flash" or "jedec-flash"


> +    Flash partitions
> +     - reg :
> +     - read-only : (optional)

I'll hold off commenting on this until you've finish writing it,
you probably know my opinion about it anyway :-)

One thing though -- what _exactly_ does "read-only" signify?


Segher
