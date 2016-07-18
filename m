Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rt9vH0zB3zDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 14:59:22 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6I4wMRC000572
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 00:59:20 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 248ncnbpq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 00:59:20 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 18 Jul 2016 14:59:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 772C32BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 14:59:15 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6I4xFf223724202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 14:59:15 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6I4xEgV027823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 14:59:15 +1000
Subject: Re: [PATCH v2] cxl: remove dead Kconfig options
To: linuxppc-dev@lists.ozlabs.org
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1468817577-1843-1-git-send-email-andrew.donnellan@au1.ibm.com>
Cc: clombard@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 mrochs@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 18 Jul 2016 14:59:14 +1000
MIME-Version: 1.0
In-Reply-To: <1468817577-1843-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <14b26416-8ead-5329-13bb-078b6badd0cd@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/07/16 14:52, Andrew Donnellan wrote:
> Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they were only
> needed to coordinate the merging of the cxlflash driver. Also remove the
> stub implementation of cxl_perst_reloads_same_image() in cxlflash which is
> only used if CXL_EEH isn't defined (i.e. never).
>
> Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>
> ---
>
> Applies on top of powerpc#next, now that the Mellanox CX-4 patches have
> been applied.

As it turns out, this patch is exactly identical to V1... oh well.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
