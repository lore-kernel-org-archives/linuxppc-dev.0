Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DC0FB7001
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2012 02:29:02 +1000 (EST)
Message-ID: <4FC8EDC4.2050704@freescale.com>
Date: Fri, 1 Jun 2012 11:28:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
In-Reply-To: <1338542089.16119.48.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2012 04:14 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2012-05-30 at 09:26 -0400, Bob Cochran wrote:
>> I believe that additional patches are required for CodeWarrior to
>> work 
>> properly (e.g., assembly start up).  I think the patches should come 
>> from Freescale.  For whatever reason, they include them in their SDK, 
>> but haven't submitted them for inclusion in the mainline.
>>
>> As a developer on Freescale Power products, I would like to see 
>> Freescale offer up a CodeWarrior patch set, so I don't have to manage 
>> the patches myself when working outside the SDK (i.e., on a more
>> recent 
>> kernel).
> 
> Such patches would have a hard time getting upstream considering that
> codewarrior is a commercial product.

It's not really about CodeWarrior -- it's needed for any external debug
on these chips.

Those chips are commercial products too, BTW. :-)

-Scott
