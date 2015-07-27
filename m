Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C309C1A305E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:56:28 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA4DD1402E8
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 15:56:27 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 27 Jul 2015 01:56:25 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DACCA38C8039
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 01:56:22 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6R5uMcK61866022
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 05:56:22 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6R5uLGR020248
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 01:56:22 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [RFC PATCH] powerpc/kexec: Wait 1s for secondaries to enter OPAL
In-Reply-To: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
References: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
Date: Mon, 27 Jul 2015 15:56:18 +1000
Message-ID: <m3r3nukut9.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Samuel Mendoza-Jonas <sam.mj@au1.ibm.com> writes:
> Always include a timeout when waiting for secondary cpus to enter OPAL
> in the kexec path, rather than only when crashing.

This *sounds* reasonable... but I wonder what actual worse case could
be and why we'd get stuck too long waiting for things?

What was the original bug/problem that inspired this patch?

and is 1s enough?
