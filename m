Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3VMv6rclzDqJ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:53:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D5ra9f049209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:53:39 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t3h6837a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:53:38 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 11:23:35 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3D5qBhD11272332
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:22:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3D5rW55022500
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:23:32 +0530
Date: Thu, 13 Apr 2017 11:23:30 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <7021f79a5738ecb25ee3e07931e927138e9493eb.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170413133758.0f9e0c86bd3230dcd820f8e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413133758.0f9e0c86bd3230dcd820f8e7@kernel.org>
Message-Id: <20170413055330.GD30806@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/13 01:37PM, Masami Hiramatsu wrote:
> On Wed, 12 Apr 2017 16:28:28 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On kprobe handler re-entry, try to emulate the instruction rather than
> > single stepping always.
> > 
> 
> > As a related change, remove the duplicate saving of msr as that is
> > already done in set_current_kprobe()
> 
> If so, this part might be separated as a cleanup patch...

Sure, thanks for the review!

- Naveen
