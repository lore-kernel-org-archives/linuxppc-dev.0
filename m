Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BBF2B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 02:11:03 +1000 (EST)
Message-ID: <4FEDD383.40804@freescale.com>
Date: Fri, 29 Jun 2012 11:10:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
 <4FEDD07D.3090103@freescale.com> <4FEDD1F0.1060000@freescale.com>
In-Reply-To: <4FEDD1F0.1060000@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2012 11:04 AM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>>> I wonder if it's possible to dynamically generate the compatible
>>> string by using the SOC name?
>>
>> Where are you going to get the SoC name from?
> 
> Well, that is why I said "I wonder".   I'm disappointed that the "cpus"
> node doesn't help much.  You'd think the name of the CPU would be in the
> CPU node somewhere.

The SoC is not the CPU.  The CPU is e500v2.

Why is this different from anywhere else where we have a list of
compatibles to match, often based on various SoCs?  Note that we
explicitly want to match only certain SoCs here.

-Scott
