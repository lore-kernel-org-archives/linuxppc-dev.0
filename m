Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v432m3VXqzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 23:25:36 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0JCOOkq032244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 07:25:33 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 282npyh32m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 07:25:33 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 19 Jan 2017 22:25:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E45772CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 23:25:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0JCPLFd6357300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 23:25:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0JCOvAF020227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 23:24:57 +1100
Subject: Re: [PATCH] cxl: drop unused header asm/pnv-pci.h
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
References: <148482301037.30441.14177888563610790803.stgit@bahia>
Cc: linux-kernel@vger.kernel.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 19 Jan 2017 23:24:26 +1100
MIME-Version: 1.0
In-Reply-To: <148482301037.30441.14177888563610790803.stgit@bahia>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ee682310-3db4-dbde-0779-cc77ba32f15e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/01/17 21:50, Greg Kurz wrote:
> The kernel API does not use anything from this header file.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
