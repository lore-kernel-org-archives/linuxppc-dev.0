Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4E277B6F18
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2011 03:04:18 +1100 (EST)
Message-ID: <4EA82F31.9060407@freescale.com>
Date: Wed, 26 Oct 2011 11:02:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/11] powerpc/85xx: Add ethernet magic packet property
 to P1020 device tree
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-4-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-5-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
 <4EA735E8.5010206@freescale.com>
 <6549A2B9-A9FD-42BC-A3B0-B920167739F5@kernel.crashing.org>
In-Reply-To: <6549A2B9-A9FD-42BC-A3B0-B920167739F5@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2011 10:35 PM, Kumar Gala wrote:
> 
> On Oct 25, 2011, at 5:19 PM, Scott Wood wrote:
> 
>> On 10/22/2011 04:20 PM, Kumar Gala wrote:
>>> All eTSEC2 controllers support waking on magic packet so fixup device
>>> tree to report that.
>>
>> If they *all* support it, we can make the driver rely on the compatible
>> instead.
>>
>> -Scott
> 
> I think this might have originated on eTSEC v1, in which all controllers don't support it.

Sure, I was just talking about nodes with fsl,etsec2 -- especially if we
have device trees already out there that are missing the property.
Easier to change the driver.

-Scott
