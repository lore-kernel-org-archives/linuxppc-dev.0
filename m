Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWLKz0vgCzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 23:13:43 +1000 (AEST)
In-Reply-To: <1465629495-17166-3-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@ozlabs.au.ibm.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/4] powerpc/perf: Power9 PMU support
Message-Id: <3rWLKy6z15z9t2G@ozlabs.org>
Date: Fri, 17 Jun 2016 23:13:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-06 at 07:18:14 UTC, Madhavan Srinivasan wrote:
> This patch adds base enablement for the power9 PMU.

This is almost line-for-line identical to the Power8 code, with the exception of
some things you haven't sent yet because they're not ready.

Can you try and factor out some of the common bits please?

Perhaps isa207-common.c ? But I don't really mind.

cheers
