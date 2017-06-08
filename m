Return-Path: <gerald.schaefer@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk9hb0w5fzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 02:23:26 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58GJBTR021810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 12:23:23 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ay8hkcq85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 12:23:23 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Thu, 8 Jun 2017 17:23:19 +0100
Date: Thu, 8 Jun 2017 18:23:11 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/44] s390: implement ->mapping_error
In-Reply-To: <20170608132609.32662-20-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-20-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20170608182311.05cced9e@thinkpad>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  8 Jun 2017 15:25:44 +0200
Christoph Hellwig <hch@lst.de> wrote:

> s390 can also use noop_dma_ops, and while that currently does not return
> errors it will so in the future.  Implementing the mapping_error method
> is the proper way to have per-ops error conditions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
