Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41CCAB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 03:00:15 +1000 (EST)
Message-ID: <4FEDDF06.10006@freescale.com>
Date: Fri, 29 Jun 2012 11:59:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 0/3] powerpc/fsl: PCI refactoring and QEMU paravirt
 platform
References: <20120627234851.GA9071@tyr.buserror.net>
 <412C8208B4A0464FA894C5F0C278CD5D01A10EAB@039-SN1MPN1-002.039d.mgd.msft.net>
 <4FEC86CC.90307@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A13620@039-SN1MPN1-002.039d.mgd.msft.net>
 <34D617F2-54CD-46DA-A110-E44CE081B99B@kernel.crashing.org>
 <4FEDD15E.10706@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F09348F0B@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F09348F0B@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2012 11:18 AM, Li Yang-R58472 wrote:
> 
> 
>> -----Original Message----- From: Wood Scott-B07421 Sent: Friday,
>> June 29, 2012 11:02 AM To: Kumar Gala Cc: Jia Hongtao-B38951; Wood
>> Scott-B07421; Li Yang-R58472; agraf@suse.de; 
>> linuxppc-dev@lists.ozlabs.org Subject: Re: [PATCH 0/3] powerpc/fsl:
>> PCI refactoring and QEMU paravirt platform
>> 
>> On 06/29/2012 10:57 AM, Kumar Gala wrote:
>>> Pretty sure the boards have ISA, if you see the .dts has
>>> references to
>> 'ISA bridge' & 'i8259' PIC.
>> 
>> OK.  How about looking for an i8259 node as well?
> 
> That could work, but looks hackish.  Our proposal for adding a new
> device tree property is a generic solution. 

Yes, all *new* boards should have an isa node.  But we want to remain
compatible with existing device trees.

> The only problem is that
> new kernels would work with old device trees.  I think we can use
> your solution for transitional period.  And go for a well defined
> device tree binding for this in long run.

The "transitional period" is until we no longer care about these
specific boards, or any out-of-tree derivatives.

-Scott
