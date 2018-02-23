Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp1gc1mbCzF1k7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 06:36:43 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NJaciu139575
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:36:41 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gaqmyks4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:36:41 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 23 Feb 2018 12:36:40 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 04/38] cxlflash: Introduce OpenCXL backend
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <abe97ecd-7162-c812-816d-268321916bff@au1.ibm.com>
Date: Fri, 23 Feb 2018 13:36:37 -0600
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1519338163-51928-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <abe97ecd-7162-c812-816d-268321916bff@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <115B47D4-5BB4-45F2-8A7A-3176C9F1EA60@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Feb 22, 2018, at 10:28 PM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> On 23/02/18 09:22, Uma Krishnan wrote:
>> Add initial infrastructure to support a new cxlflash transport, =
OpenCXL.
>> Claim a dependency on OpenCXL (OCXL) and add a new file, ocxl_hw.c, =
which
>> will host the backend routines that are specific to OpenCXL.
>> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
>=20
> Is it necessary to depend on OCXL in all cases? IMHO it should be =
possible to build a cxl-only version without ocxl, though I don't feel =
very strongly on this.

I thought through this and did not feel it is necessary to distinguish =
right now. I will look at adding this in the future. Thanks Andrew !=
