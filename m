Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqfHj3vB1zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:08:17 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6E24IF2057047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:08:14 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24567dkh50-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 22:08:14 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Jul 2016 12:08:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 722472BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:08:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6E283IJ16777318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:08:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6E282dq002141
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:08:03 +1000
Subject: Re: [PATCH] cxl: remove dead Kconfig options
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <yq1k2gpm0y0.fsf@sermon.lab.mkp.net>
 <984bdc4c-1522-f166-c4c2-4f7e5b08909a@au1.ibm.com>
Cc: clombard@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 14 Jul 2016 12:07:32 +1000
MIME-Version: 1.0
In-Reply-To: <984bdc4c-1522-f166-c4c2-4f7e5b08909a@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a67d8502-8b1c-e00d-106f-d223f7bddc63@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 12:05, Andrew Donnellan wrote:
> Sorry for not stating explicitly - I'd like this taken through powerpc
> as the cxlflash change is incidental to the cxl changes.

I'll also be submitting a v2 that applies on top of another cxl series 
that hasn't been merged yet.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
