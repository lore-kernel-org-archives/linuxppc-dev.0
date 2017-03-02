Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYjlv4RjfzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:56:43 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v226sbiR143587
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 01:56:41 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xcv3uvp3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 01:56:41 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Mar 2017 16:56:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6BF142CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:56:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v226uSp635324116
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 17:56:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v226u4tl014557
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 17:56:04 +1100
Subject: Re: [PATCH 7/7] cxl: Add psl9 specific code
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-8-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Mar 2017 17:55:39 +1100
MIME-Version: 1.0
In-Reply-To: <1485970213-25532-8-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <318497cd-8548-d5b5-2485-6bf00c56e280@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/17 04:30, Christophe Lombard wrote:
> The new Coherent Accelerator Interface Architecture, level 2, for the
> IBM POWER9 brings new content and features:
> - POWER9 Service Layer
> - Registers
> - Radix mode
> - Process element entry
> - Dedicated-Shared Process Programming Model
> - Translation Fault Handling
> - CAPP
> - Memory Context ID
>     If a valid mm_struct is found the memory context id is used for each
>     transaction associated with the process handle. The PSL uses the
>     context ID to find the corresponding process element.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Patch needs rebasing, see:

https://github.com/ajdlinux/linux/commit/642ec862c7074c19765a2dd385dc5fd1751104b4


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
