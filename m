Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtPmR0McTzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 23:54:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6IDrWGF132893
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:54:12 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 248ncnurcr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:54:12 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 18 Jul 2016 09:54:11 -0400
Subject: Re: [PATCH] cxl: add option to enable -DDEBUG
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1468829857-821-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <877fcjb4rm.fsf@@concordia.ellerman.id.au>
Cc: clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com, felix@linux.vnet.ibm.com
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Mon, 18 Jul 2016 08:54:05 -0500
MIME-Version: 1.0
In-Reply-To: <877fcjb4rm.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3b6b37ab-f146-73ee-6b32-b9d63a52eac5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 7/18/2016 5:49 AM, Michael Ellerman wrote:
> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>
>> Developers working on AFUs and AFU drivers often find it useful to see the
>> pr_devel() and dev_dbg() messages from cxl. Give them an easy way to enable
>> -DDEBUG by adding a Kconfig option, CONFIG_CXL_DEBUG.
>
> Another option is to use DYNAMIC_DEBUG. If you turn that on the
> dev_dbg()'s can be enabled at runtime, and you could en masse or
> selectively convert the pr_devel()s to pr_debug() to get the same
> result.
>
> cheers
>

Andrew, DYNAMIC_DEBUG would be more useful for us because it can be 
enabled at runtime just like we do for cxlflash.
