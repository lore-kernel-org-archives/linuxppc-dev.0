Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTZQl6lfJzDwMV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 09:12:15 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUM9ePi030009
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:12:14 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27260hu77n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:12:13 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 15:12:13 -0700
Subject: Re: [PATCH v2 11/14] cxlflash: Cleanup send_tmf()
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1480379984-60114-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1480380170-60570-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 16:12:57 -0600
MIME-Version: 1.0
In-Reply-To: <1480380170-60570-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8ac81f06-f52d-d45a-c756-1d2dc8bfb8be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> The send_tmf() routine includes some copy/paste cruft that can be
> removed as well as the setting of an AFU command-specific while
> holding the tmf_slock. While not a bug, it is out of place and
> should be shifted down alongside the other command initialization
> statements for clarity.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Acked-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
