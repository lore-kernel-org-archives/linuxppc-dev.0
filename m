Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96D882C0102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 06:13:04 +1000 (EST)
Message-ID: <50086A45.8000907@freescale.com>
Date: Thu, 19 Jul 2012 15:12:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
References: <20120614234101.GB17147@tyr.buserror.net>
 <1339722302.9220.175.camel@pasglop>
In-Reply-To: <1339722302.9220.175.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2012 08:05 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-06-14 at 18:41 -0500, Scott Wood wrote:
>>  - Like on e5500, the linear mapping is bolted, so we don't need the
>>    overhead of supporting nested tlb misses.
>>
>> Note that hardware tablewalk does not work in rev1 of e6500.
>> We do not expect to support e6500 rev1 in mainline Linux.
> 
> I'll try to review that in more details next week.... 
> 
> Ben.

ping

-Scott
