Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3VMd6CfVzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:53:33 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D5hgjU051400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:53:21 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sw2acbpp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:53:20 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 11:23:17 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3D5rEd914155898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:23:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3D5rAqj021656
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:23:13 +0530
Date: Thu, 13 Apr 2017 11:23:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] powerpc: kprobes: factor out code to emulate
 instruction into a helper
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <6058a453bd013d5fad41201c01915889cccb0ac6.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170413133448.d13e8489238b4dc8bee9471c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413133448.d13e8489238b4dc8bee9471c@kernel.org>
Message-Id: <20170413055309.GC30806@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/13 01:34PM, Masami Hiramatsu wrote:
> On Wed, 12 Apr 2017 16:28:27 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > This helper will be used in a subsequent patch to emulate instructions
> > on re-entering the kprobe handler. No functional change.
> 
> In this case, please merge this patch into the next patch which
> actually uses the factored out function unless that changes
> too much.

Ok, will do.

Thanks,
Naveen
