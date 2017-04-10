Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1g0L24dPzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:15:30 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A6Ds4w099498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 02:15:13 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29r4eyga88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 02:15:12 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 10 Apr 2017 16:15:09 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A6ExBD39846014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:15:07 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A6EY0D032408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:14:34 +1000
Subject: Re: [PATCH V4 5/7] cxl: Rename some psl8 specific functions
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-6-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 10 Apr 2017 16:14:10 +1000
MIME-Version: 1.0
In-Reply-To: <1491574319-11852-6-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <bb6a668c-0338-804c-f4b6-c0e593239711@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/17 00:11, Christophe Lombard wrote:
> Rename a few functions, changing the '_psl' suffix to '_psl8', to make
> clear that the implementation is psl8 specific.
> Those functions will have an equivalent implementation for the psl9 in
> a later patch.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
