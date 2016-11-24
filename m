Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPKYJ04SWzDw3Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 11:18:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAO0EK7A030989
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 19:18:08 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26wcr2nupr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 19:18:07 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Nov 2016 10:18:05 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1C118357805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 11:18:03 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAO0I2nt49414162
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 11:18:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAO0I27B004296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 11:18:02 +1100
Subject: Re: [PATCH] cxl: drop duplicate header sched.h
To: Geliang Tang <geliangtang@gmail.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <b7081e3aaf7867b3f9fef64e48198d3025352633.1479914776.git.geliangtang@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Nov 2016 11:17:59 +1100
MIME-Version: 1.0
In-Reply-To: <b7081e3aaf7867b3f9fef64e48198d3025352633.1479914776.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ebb37b59-9f35-e58f-2d8f-c8329a96bce4@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/11/16 02:27, Geliang Tang wrote:
> Drop duplicate header sched.h from native.c.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Good catch!

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
