Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTR9f1djpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:45:42 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N7hgHi095651
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:45:40 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28shbjd6m0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:45:40 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Feb 2017 17:45:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CB68C3578058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:45:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N7jRtl48693286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:45:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N7j3i2025183
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:45:03 +1100
Subject: Re: [PATCH] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170223022954.14676-1-matthew.brown.dev@gmail.com>
 <9d2269d4-0e90-6e08-94d8-a5f49ebbd6c2@au1.ibm.com>
Cc: Matt Brown <brownmatt1997@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Feb 2017 18:44:38 +1100
MIME-Version: 1.0
In-Reply-To: <9d2269d4-0e90-6e08-94d8-a5f49ebbd6c2@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9f3fad4a-6f7a-4d12-8011-ed672de8003d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/02/17 18:42, Andrew Donnellan wrote:
> I haven't checked the actual important bit of how HDAT is exposed in
> device tree but other than that things look fairly good. Boring
> stylistic comments below!

And now that I have - it's probably worth noting that this patch depends 
on a corresponding skiboot patch at 
http://patchwork.ozlabs.org/patch/731385/

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
