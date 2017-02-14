Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMx0N2X5bzDqvj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:48:36 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8mVTU082526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:48:34 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kv2dp6x3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:48:33 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 18:48:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9B0453578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:48:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E8mIN233751170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:48:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E8lr5x020879
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:47:54 +1100
Date: Tue, 14 Feb 2017 14:17:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 lsorense@csclub.uwaterloo.ca, oohall@gmail.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net
Subject: Re: [PATCH v2 1/2] powerpc: Emulation support for load/store
 instructions on LE
References: <1487059332-6925-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487059332-6925-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487059332-6925-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20170214084734.GG7674@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/14 01:32PM, Ravi Bangoria wrote:
> emulate_step() uses a number of underlying kernel functions that were
> initially not enabled for LE. This has been rectified since. So, fix
> emulate_step() for LE for the corresponding instructions.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Can you redo this on top of powerpc/next? This doesn't apply cleanly due 
to a recent change...

- Naveen
