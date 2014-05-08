Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D460140129
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 13:36:56 +1000 (EST)
Message-ID: <1399520191.15726.371.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/6] powerpc/corenet: Create the dts components for the
 DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Wed, 7 May 2014 22:36:31 -0500
In-Reply-To: <536AF8C7.8080304@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
 <1398118262.1694.188.camel__8135.6513932862$1398128944$gmane$org@snotra.buserror.net>
 <5364BEB3.6000904@Freescale.com>
 <1399332359.15726.154.camel@snotra.buserror.net>
 <53687913.70900@Freescale.com>
 <1399431248.15726.255.camel@snotra.buserror.net>
 <536AF8C7.8080304@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-07 at 22:23 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> At this point, I'm getting a bit lost in this thread and I feel we're
> getting into more generic comments. I'll continue to answer to some of
> your comments to make sure I understand them. However, one major comment
> I feel you made was about seeing a full FMan binding. If that's a deal
> breaker, please let me know and we'll just drop the patches

It's not an absolute deal breaker -- I did suggest the possibility of
providing the mdio node as an ordinary ccsr node, not underneath an fman
container.

I'm just frustrated that getting a proper fman node is such a big deal.
That should have been the first step of the upstreaming process -- not
something that waits until everything is finished.

-Scott
