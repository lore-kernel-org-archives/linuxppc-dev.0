Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 11:39:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: New fsl device bindings file
Message-ID: <20080707013902.GI6267@yookeroo.seuss>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
	<fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
	<8C77F02F-E930-40EB-AE25-F959C40833B3@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8C77F02F-E930-40EB-AE25-F959C40833B3@lixom.net>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 05, 2008 at 12:24:56AM -0500, Olof Johansson wrote:
>
> On Jul 3, 2008, at 1:34 PM, Grant Likely wrote:
>
>>> How about splitting up like this:
>>>
>>> Documentation/powerpc/device-tree/fsl/cpm.txt
>>> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
>>> Documentation/powerpc/device-tree/fsl/tsec.txt
>>> Documentation/powerpc/device-tree/interrupts.txt
>>> Documentation/powerpc/device-tree/dtb.txt
>>
>> May I suggest moving it to Documentation/of-bindings/ instead?  Some
>> of these bindings (granted, not the fsl ones) will be used by
>> non-powerpc platforms (sparc, microblaze).
>
> Good idea, but:
>
> Don't call the bindings OF. They're not.
>
> They are a linux-specific binding that happens to use the same data  
> structures and representation that OF does.

Well... they may be Linux specific by default, but they're supposed to
be general enough that they (or at least, very small extensions)
*could* become official OF bindings, if there was still an OF group to
make them so.  It certainly should be possible to use these bindings
in a firmware which provides an OF client interface as well as in
flat-tree-only firmwares which don't.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
