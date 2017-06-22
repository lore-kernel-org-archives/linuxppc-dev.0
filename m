Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtsmQ4cPPzDr6c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:56:54 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MJriLY001671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:56:52 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8dhwn0vj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:56:52 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 13:56:51 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 08/17] cxlflash: Add scsi command abort handler
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1498097706-8970-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 14:56:36 -0500
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1498097563-8680-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1498097706-8970-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-Id: <2BE3376B-C0C2-4CA9-BEE0-5889844DC46F@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 21, 2017, at 9:15 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> To date, CXL flash devices do not support a single command abort =
operation.
> Instead, the SISLite specification provides a context reset operation =
to
> cleanup all pending commands for a given context.
>=20
> When a context reset is successful, it is guaranteed that the AFU has
> aborted all currently pending I/O. This sequence is less invasive than =
a
> device or host reset and can be executed to support scsi command abort
> requests. Add eh_abort_handler callback support to process command =
timeouts
> and abort requests.
>=20
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
