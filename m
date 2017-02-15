Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNPcg3VWDzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 14:18:11 +1100 (AEDT)
Subject: Re: [PATCH 2/2] powerpc/powernv/opal-dump : Use IRQ_HANDLED instead
 of numbers in interrupt handler
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <f87a41d5-9647-67c4-735e-a7df86c4ff3a@ozlabs.org>
Date: Wed, 15 Feb 2017 11:18:10 +0800
MIME-Version: 1.0
In-Reply-To: <1480583289-6380-2-git-send-email-mukesh02@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Mukesh,

> Converts all the return explicit number to a more proper IRQ_HANDLED,
> which looks proper incase of interrupt handler returning case.

This looks good to me, but can you describe the effects of those changes
to the interrupt handler's return code? ie, what happened in the
erroneous case where we returned 0 (== IRQ_NONE) - does this fix a
user-visible issue?

Cheers,


Jeremy
