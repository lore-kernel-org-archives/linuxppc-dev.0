Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Tcw1t1qzDvSq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:22:56 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REJ6cV098483
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:22:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26bjes3p1t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:22:53 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 08:22:52 -0600
Subject: Re: [PATCH v6 3/3] powerpc/pseries: Implement indexed-count hotplug
 memory remove
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20161018172053.37287.78128.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Cc: sahilmehta17@gmail.com
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2016 09:22:48 -0500
MIME-Version: 1.0
In-Reply-To: <20161018172053.37287.78128.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c39e13b4-c7f8-312b-6197-40d710750133@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/2016 12:21 PM, Nathan Fontenot wrote:
> From: Sahil Mehta <sahilmehta17@gmail.com>
> 
> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---

Reviewed-by: John Allen <jallen@linux.vnet.ibm.com>
