Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC9B4B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 03:11:56 +1000 (EST)
Message-ID: <4FEDE184.7070109@freescale.com>
Date: Fri, 29 Jun 2012 12:10:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXWiGOCtP1iJYR2S48XwR2Wpry8+VswctctdVfY9Z+QTiQ@mail.gmail.com>
 <4FEDD07D.3090103@freescale.com> <4FEDD1F0.1060000@freescale.com>
 <4FEDD383.40804@freescale.com> <4FEDD3EB.7090606@freescale.com>
In-Reply-To: <4FEDD3EB.7090606@freescale.com>
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

On 06/29/2012 11:12 AM, Timur Tabi wrote:
> Scott Wood wrote:
>> Why is this different from anywhere else where we have a list of
>> compatibles to match, often based on various SoCs?  Note that we
>> explicitly want to match only certain SoCs here.
> 
> I was just hoping to find a way to avoid an ever increasing list of
> compatible strings. 

PCI drivers have to put up with it, why should we be different? :-)

> Other posts on this thread imply that this code could
> work for all multi-core e500 parts.

That list covers all multi-core e500v2 parts that I know of.  Corenet
based chips will need a slightly different implementation, since the
registers are different.

-Scott
