Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 277211A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 16:00:39 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 3 Mar 2016 15:00:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 18E893578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 16:00:36 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2350R9U4194634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 16:00:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u235030O017598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 16:00:03 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>, mpe <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 08/18] cxl: IRQ allocation for guests
In-reply-to: <1456244519-18934-9-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-9-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 03 Mar 2016 15:59:08 +1100
Message-Id: <1456981024-sup-7266@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +                /*
> +                 * The very first interrupt of range 0 is
> +                 * always the PSL interrupt, but we only
> +                 * need to connect a handler for guests,
> +                 * because there's one PSL interrupt per
> +                 * context.
> +                 * On bare-metal, the PSL interrupt is
> +                 * multiplexed and was setup when the AFU
> +                 * was configured.
> +                 */

Thanks for expanding that comment :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
