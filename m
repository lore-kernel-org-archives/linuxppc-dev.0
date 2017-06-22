Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtslC1d34zDr7w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:55:51 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MJrhdK069922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:55:49 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8k2xu9pe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:55:49 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 13:55:48 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 05/17] cxlflash: Handle AFU sync failures
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1498097670-8862-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:55:42 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1498097563-8680-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1498097670-8862-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-Id: <E4210FEF-3158-466C-9878-F59E3B53842F@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 21, 2017, at 9:14 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> AFU sync operations are not currently evaluated for failure. This is
> acceptable for paths where there is not a dependency on the AFU being
> consistent with the host. Examples include link reset events and LUN
> cleanup operations. On paths where there is a dependency, such as a =
LUN
> open, a sync failure should be acted upon.
>=20
> In the event of AFU sync failures, either log or cleanup as =
appropriate for
> operations that are dependent on a successful sync completion.
>=20
> Update documentation to reflect behavior in the event of an AFU sync
> failure.
>=20
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
