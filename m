Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqfDF6LD1zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:05:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6E24JwI073717
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:05:15 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452xsk74y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:05:15 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Jul 2016 12:05:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AECF2357805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:05:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6E259Cq25231418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:05:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6E258Z9027746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:05:09 +1000
Subject: Re: [PATCH] cxl: remove dead Kconfig options
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <yq1k2gpm0y0.fsf@sermon.lab.mkp.net>
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 mrochs@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 manoj@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 14 Jul 2016 12:05:08 +1000
MIME-Version: 1.0
In-Reply-To: <yq1k2gpm0y0.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <984bdc4c-1522-f166-c4c2-4f7e5b08909a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 12:02, Martin K. Petersen wrote:
>>>>>> "Andrew" == Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>
> Andrew> Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they
> Andrew> were only needed to coordinate the merging of the cxlflash
> Andrew> driver. Also remove the stub implementation of
> Andrew> cxl_perst_reloads_same_image() in cxlflash which is only used if
> Andrew> CXL_EEH isn't defined (i.e. never).
>
> This patch straddles a few subsystems. Did you intend for me to queue it
> through SCSI?

Sorry for not stating explicitly - I'd like this taken through powerpc 
as the cxlflash change is incidental to the cxl changes.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
