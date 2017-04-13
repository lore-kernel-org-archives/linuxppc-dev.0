Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3w1z53zNzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 08:09:43 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DLwnfA075867
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:09:38 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t6qvxycj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:09:38 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 18:09:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 15/17] cxlflash: Support multiple hardware queues
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1492024542-56194-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 17:09:23 -0500
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1492024215-55579-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1492024542-56194-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-Id: <29FD7426-117A-460F-853A-614E69250A42@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Apr 12, 2017, at 2:15 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> Introduce multiple hardware queues to improve legacy I/O path =
performance.
> Each hardware queue is comprised of a master context and associated =
I/O
> resources. The hardware queues are initially implemented as a static =
array
> embedded in the AFU. This will be transitioned to a dynamic allocation =
in a
> later series to improve the memory footprint of the driver.
>=20
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Looks good!

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>=
