Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3NvX2sVMzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:46:32 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u724hs2Y011051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:46:29 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gr47wpgs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:46:29 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:46:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 126BD3578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:46:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724kN5m21889092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:46:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724kMZ1005727
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:46:22 +1000
Date: Tue, 2 Aug 2016 14:46:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3] powernv/pci: Add PHB register dump debugfs handle
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160728050503.17366-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160728050503.17366-1-ruscur@russell.cc>
Message-Id: <20160802044621.GA23976@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 28, 2016 at 03:05:03PM +1000, Russell Currey wrote:
>On EEH events the kernel will print a dump of relevant registers.
>If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
>doesn't have EEH support, etc) this information isn't readily available.
>
>Add a new debugfs handler to trigger a PHB register dump, so that this
>information can be made available on demand.
>
>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
