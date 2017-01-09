Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txm4w6yXNzDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 17:50:39 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v096mT6Q008156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 01:50:36 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27urhugn8w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 01:50:36 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 9 Jan 2017 16:50:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB4E5357805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 17:50:20 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v096oKxR1835306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 17:50:20 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v096oKRn023032
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 17:50:20 +1100
Subject: Re: [PATCH 3/4] cxlflash: Cleanup prints
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1483711379-18188-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1483711518-18302-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 9 Jan 2017 17:50:19 +1100
MIME-Version: 1.0
In-Reply-To: <1483711518-18302-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <eda1310f-94b2-1c34-5dd4-cbb4ba21be43@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/17 01:05, Uma Krishnan wrote:
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> The usage of prints within the cxlflash driver is inconsistent. This
> hinders debug and makes the driver source and log output appear sloppy.
>
> The following cleanups help unify the prints within cxlflash:
>  - move all prints to dev-* where possible
>  - transition all hex prints to lowercase
>  - standardize variable prints in debug output
>  - derive pointers in a consistent manner
>  - remove superfluous data from prints and print statements that do not
>    make sense

And change a couple of ints to bools, which isn't strictly print-related. :)

>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

An impressive cleanup! Nothing bad which stands out to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
