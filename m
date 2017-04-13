Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3VJM4wfnzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:50:43 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D5jcgg138418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:50:33 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t248ts5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:50:33 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 11:20:30 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3D5oRYQ16646276
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:20:27 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3D5oPvg017185
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:20:26 +0530
Date: Thu, 13 Apr 2017 11:20:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] powerpc: a few kprobe fixes and refactoring
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170413120217.0a1223bdaea42448ec011c66@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413120217.0a1223bdaea42448ec011c66@kernel.org>
Message-Id: <20170413055024.GA30806@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/13 12:02PM, Masami Hiramatsu wrote:
> Hi Naveen,

Hi Masami,

> 
> BTW, I saw you sent 3 different series, are there any
> conflict each other? or can we pick those independently?

Yes, all these three patch series are based off powerpc/next and they do 
depend on each other, as they are all about powerpc kprobes.

Patches 1 and 2 in this series touch generic kprobes bits and Michael 
was planning on putting those in a topic branch so that -tip can pull 
them too.

Apart from those two, your optprobes patch 3/5 
(https://patchwork.ozlabs.org/patch/749934/) also touches generic code, 
but it is needed for KPROBES_ON_FTRACE on powerpc. So, I've posted that 
as part of my series. We could probably also put that in the topic 
branch.


Thanks,
Naveen
