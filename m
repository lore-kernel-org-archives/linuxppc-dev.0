Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9484FDE08D
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 06:32:57 +1100 (EST)
Message-Id: <5A5CAF9E-EE0B-406F-BBB9-8BE23BEB6F14@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1230960630.15389.102.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Status of fsl booke TLB and ATMU patches
Date: Sat, 3 Jan 2009 13:32:48 -0600
References: <Pine.LNX.4.58.0901021611260.25853@shell2.speakeasy.net>
	<1230960630.15389.102.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 2, 2009, at 11:30 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-01-02 at 16:18 -0800, Trent Piepho wrote:
>> 2.6.28 is out, can my existing patches be accepted?
>
> It's all FSL stuff and thus in Kumar's hands. I think there's a  
> pending
> pull request from him tho, thus maybe they are in there already :-)
>
> I've just officially taken over so I'll scrub patchwork and  
> outstanding
> sub maintainer pull requests if any early next week.
>
> Cheers,
> Ben.

Neither of these patch sets are in my pull request.  The PCI ones  
should be ok, but I need to review.

The TLB ones I'm still a bit concerned about their impact on the KVM  
fsl-booke port.

>> [2/2] POWERPC/fsl-pci: Set relaxed ordering on prefetchable ranges
>> http://patchwork.ozlabs.org/patch/14546/
>>
>> [1/2] POWERPC/fsl-pci: Better ATMU setup
>> http://patchwork.ozlabs.org/patch/14544/
>>
>> [5/5] powerpc: booke: Allow larger CAM sizes than 256 MB
>> http://patchwork.ozlabs.org/patch/12885/
>>
>> [4/5] powerpc: booke: Make CAM entries used for lowmem configurable
>> http://patchwork.ozlabs.org/patch/12884/
>>
>> [3/5] powerpc: booke: Remove code duplication in lowmem mapping
>> http://patchwork.ozlabs.org/patch/12883/
>>
>> [2/5] powerpc: booke: Remove num_tlbcam_entries
>> http://patchwork.ozlabs.org/patch/12882/
>>
>> [1/5] powerpc: booke: Don't hard-code size of struct tlbcam
>> http://patchwork.ozlabs.org/patch/12881/
>>

- k
