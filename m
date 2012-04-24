Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D574B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 08:05:25 +1000 (EST)
Message-ID: <4F972380.6030202@freescale.com>
Date: Tue, 24 Apr 2012 17:04:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
References: <1335220202-32533-1-git-send-email-grant.likely@secretlab.ca>
 <1335220202-32533-2-git-send-email-grant.likely@secretlab.ca>
 <1335237195.24897.0.camel@pasglop>
 <OF4123672B.F86C969F-ONC12579EA.002A2C1F-C12579EA.002A48C2@transmode.se>
 <1335266570
In-Reply-To: <1335266570.15830.11.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2012 06:22 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-04-24 at 09:41 +0200, Joakim Tjernlund wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/04/24 05:13:15:
>>>
>>> On Mon, 2012-04-23 at 16:30 -0600, Grant Likely wrote:
>>>> The mpc8xx driver uses a reference to NR_IRQS that is buggy.  It uses
>>>> NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
>>>> NR_IRQs could be smaller than the number of hardware irqs that
>>>> ppc_cached_irq_mask tracks.
>>>
>>> Joakim, any chance you can test this ASAP ? :-)
>>
>> Sorry, but no.  We have not moved our 8xx boards to 3.x as it in maintenance
>> and takes too much space.
> 
> Ah ok... Anybody else on the list who still has some 8xx gear ?

Boots OK on ep88xc.

-Scott
