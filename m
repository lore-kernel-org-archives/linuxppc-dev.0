Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg355YXMzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:45 +1000 (AEST)
In-Reply-To: <1487596931-26975-1-git-send-email-mukesh02@linux.vnet.ibm.com>
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, stewart@linux.vnet.ibm.com,
 jk@ozlabs.org, hegdevasant@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: Re: [V2,
 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info properly
Message-Id: <41Zg345gqGz9s0R@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-20 at 13:22:10 UTC, Mukesh Ojha wrote:
> Moves the return value check of 'opal_dump_info' to a proper place which
> was previously unnecessarily filling all the dump info even on failure.
> 
> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a5bbe8fd29f7e42fe5d26371adbad9

cheers
