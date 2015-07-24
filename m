Return-Path: <brking@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B23341A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 05:55:48 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 24 Jul 2015 13:55:46 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9104A19D8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 13:46:42 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t6OJsrV447448126
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 12:54:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6OJthnb006097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 13:55:43 -0600
Message-ID: <55B2983E.5020300@linux.vnet.ibm.com>
Date: Fri, 24 Jul 2015 14:55:42 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/3] powerpc/iommu: Support "hybrid" iommu/direct DMA
 ops for coherent_mask < dma_mask
References: <1435123531.3996.31.camel@kernel.crashing.org>
In-Reply-To: <1435123531.3996.31.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

It looks like this patch has bit rot. I have a system now where I can test the
latest version. Any chance you can rediff and resend and I can test?

Thanks,

Brian
