Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 2A726DDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 15:24:58 +1000 (EST)
Message-Id: <8C77F02F-E930-40EB-AE25-F959C40833B3@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: New fsl device bindings file
Date: Sat, 5 Jul 2008 00:24:56 -0500
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
	<fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
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


On Jul 3, 2008, at 1:34 PM, Grant Likely wrote:

>> How about splitting up like this:
>>
>> Documentation/powerpc/device-tree/fsl/cpm.txt
>> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
>> Documentation/powerpc/device-tree/fsl/tsec.txt
>> Documentation/powerpc/device-tree/interrupts.txt
>> Documentation/powerpc/device-tree/dtb.txt
>
> May I suggest moving it to Documentation/of-bindings/ instead?  Some
> of these bindings (granted, not the fsl ones) will be used by
> non-powerpc platforms (sparc, microblaze).

Good idea, but:

Don't call the bindings OF. They're not.

They are a linux-specific binding that happens to use the same data  
structures and representation that OF does.

Call them dts-bindings or something else, just to avoid confusion.


-Olof
