Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMxfn1VPzzDqPF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 20:18:25 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E9E2dj046137
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:18:23 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kxysreq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 04:18:23 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 02:18:22 -0700
Subject: Re: [PATCH v2 1/2] powerpc: Emulation support for load/store
 instructions on LE
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1487059332-6925-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487059332-6925-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20170214084734.GG7674@naverao1-tp.localdomain>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 lsorense@csclub.uwaterloo.ca, oohall@gmail.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 14:48:07 +0530
MIME-Version: 1.0
In-Reply-To: <20170214084734.GG7674@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58A2CB4F.30201@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 14 February 2017 02:17 PM, Naveen N. Rao wrote:
> On 2017/02/14 01:32PM, Ravi Bangoria wrote:
>> emulate_step() uses a number of underlying kernel functions that were
>> initially not enabled for LE. This has been rectified since. So, fix
>> emulate_step() for LE for the corresponding instructions.
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Can you redo this on top of powerpc/next? This doesn't apply cleanly due 
> to a recent change...

Ok. sorry for the noise. I sent a v3 series. Please review it.

Ravi

> - Naveen
>
