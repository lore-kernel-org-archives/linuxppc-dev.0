Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8Yjs65FjzDsxc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:41:21 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA35dlGp029618
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 01:41:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fnf6efbm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 01:41:19 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 01:41:18 -0400
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
To: Anton Blanchard <anton@samba.org>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, duwe@lst.de, ast@kernel.org,
 viro@zeniv.linux.org.uk, chris@distroguy.com, oss@buserror.net,
 paul.gortmaker@windriver.com, oohall@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 3 Nov 2016 11:11:06 +0530
MIME-Version: 1.0
In-Reply-To: <20161103080412.68240cda@kryten>
Content-Type: text/plain; charset=windows-1252
Message-Id: <581ACDF2.1010409@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 03 November 2016 02:34 AM, Anton Blanchard wrote:
> Hi Ravi,
>
>> emulate_step() uses a number of underlying kernel functions that were
>> initially not enabled for LE. This has been rectified since. So, fix
>> emulate_step() for LE for the corresponding instructions.
> Thanks. Should this be queued up for stable?

Thanks Anton. Yes, this should go in stable.

-Ravi
