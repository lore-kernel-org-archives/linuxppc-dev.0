Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 1D438DDE01
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 14:26:35 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1101539rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 21:26:34 -0700 (PDT)
Date: Thu, 3 Jul 2008 22:26:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: New fsl device bindings file
Message-ID: <20080704042601.GI12945@secretlab.ca>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
	<fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
	<BE229B94-773D-4FA8-AFD0-E46F5887F8D3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE229B94-773D-4FA8-AFD0-E46F5887F8D3@kernel.crashing.org>
Sender: Grant Likely <glikely@secretlab.ca>
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

On Thu, Jul 03, 2008 at 01:38:17PM -0500, Kumar Gala wrote:
>
> On Jul 3, 2008, at 1:34 PM, Grant Likely wrote:
>
>> On Thu, Jul 3, 2008 at 12:28 PM, Scott Wood <scottwood@freescale.com> 
>> wrote:
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
> I think the powerpc bindings should still be under Docs/powerpc/of- 
> bindings/
>
> It makes it cleaner in that each arch/sub-arch maintainer can maintain  
> Docs/<arch>/of-bindings and we can all vet changes to Docs/of-bindings

Personally, I think it would still be better to keep everything in one
place, even if large parts of it are arch specific.  I think it would
encourage people to look across architecture boundaries when looking for
examples of how to document device tree bindings.  It would also
discourage accidental duplication for parts that end up being used in
more than one architectures (ie. spi and i2c devices).  Not everyone is
going to be well versed on the rules of what bindings should be arch
specific and what should go in the common dir.  It will make everyone's
life easier if there is only one place to look.

(oh, and I think the subdirectories by manufacturer is a good layout).

g.
