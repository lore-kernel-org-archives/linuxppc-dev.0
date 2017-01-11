Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyvdB1ZQFzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 14:34:04 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B3Y2v6098490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 22:34:02 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27w8j518f7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 22:34:02 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 22:33:58 -0500
Subject: Re: [PATCH 0/4] cxlflash: Enhancements, cleanup and fixes
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1483711379-18188-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <yq1ziizbjaw.fsf@oracle.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 21:33:52 -0600
MIME-Version: 1.0
In-Reply-To: <yq1ziizbjaw.fsf@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0704aa9b-c671-420b-efd9-9627cf9c5636@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/9/2017 11:00 PM, Martin K. Petersen wrote:
>>>>>> "Uma" == Uma Krishnan <ukrishn@linux.vnet.ibm.com> writes:
>
> Uma,
>
> Uma> This patch series includes an enhancement to support a new command
> Uma> queuing model and also cleans up prints throughout the driver. The
> Uma> last patch in the series fixes a racing issue.
>
> Uma> The series is based upon v4.10-rc2, intended for 4.11 and is
> Uma> bisectable.
>
> Uma> Matthew R. Ochs (3):
> Uma>   cxlflash: Refactor context reset to share reset logic cxlflash:
> Uma>   Support SQ Command Mode cxlflash: Cleanup prints
>
> The first three patches in the series were submitted by you but do not
> carry your Signed-off-by:...
>

I will send out a V2 with the SOBs soon. Thanks for pointing out!
