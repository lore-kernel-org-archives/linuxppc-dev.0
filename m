Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BB811A162B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 11:06:47 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 20 Dec 2015 17:06:45 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AAA1319D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 16:54:45 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBL06flw28114948
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 17:06:41 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBL06fvt007982
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 17:06:41 -0700
From: Stewart Smith <sesmith@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv: Only delay opal_rtc_read() retry when
 necessary
In-Reply-To: <1450435564.2791.98.camel@neuling.org>
References: <1450435564.2791.98.camel@neuling.org>
Date: Mon, 21 Dec 2015 11:06:34 +1100
Message-ID: <87a8p4mzqt.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Only delay opal_rtc_read() when busy and are going to retry.
>
> This has the advantage of possibly saving a massive 10ms off booting!
>
> Kudos to Stewart for noticing.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
