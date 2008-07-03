Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 64591DE023
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:34:11 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so5618847agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 11:34:10 -0700 (PDT)
Message-ID: <fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
Date: Thu, 3 Jul 2008 12:34:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: New fsl device bindings file
In-Reply-To: <486D1A58.8010403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 3, 2008 at 12:28 PM, Scott Wood <scottwood@freescale.com> wrote:
> Kumar Gala wrote:
>>
>> I'm sure you'll hate for doing this, but I've asked Kim to create a new
>> Documentation/powerpc/fsl-device-tree-bindings.txt as part of his SEC patch.
>>
>> I'm going to move all the Freescale SoC related bindings into this new
>> file.  One of the aspects of the new file is we will NOT having an ordinal
>> heading index.

Not at all.  This is much needed.  The current file is far to unwieldy

>
> How about splitting up like this:
>
> Documentation/powerpc/device-tree/fsl/cpm.txt
> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
> Documentation/powerpc/device-tree/fsl/tsec.txt
> Documentation/powerpc/device-tree/interrupts.txt
> Documentation/powerpc/device-tree/dtb.txt

May I suggest moving it to Documentation/of-bindings/ instead?  Some
of these bindings (granted, not the fsl ones) will be used by
non-powerpc platforms (sparc, microblaze).

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
