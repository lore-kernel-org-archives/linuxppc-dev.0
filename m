Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3VLH6nLKzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:52:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D5jqxM014372
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:52:15 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t19xmd2s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:52:15 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 11:22:11 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3D5olaQ6422738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:20:47 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3D5q8I7000879
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:22:09 +0530
Date: Thu, 13 Apr 2017 11:22:06 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] powerpc: introduce a new helper to obtain
 function entry points
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <0f8685ca8b0d0b467a0d5ae60e666558d85062ed.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170413133221.a11fafe3f1f776517cce9663@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413133221.a11fafe3f1f776517cce9663@kernel.org>
Message-Id: <20170413055206.GB30806@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/13 01:32PM, Masami Hiramatsu wrote:
> On Wed, 12 Apr 2017 16:28:26 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > kprobe_lookup_name() is specific to the kprobe subsystem and may not
> > always return the function entry point (in a subsequent patch for
> > KPROBES_ON_FTRACE).
> 
> If so, please move this patch into that series. It is hard to review
> patches which requires for other series.

:-)
This patch was originally the first in this series to try avoiding the 
need for converting kprobe_lookup_name() in optprobes.c. But, with the 
re-shuffle, this is more suitable in the other series. I will move it.

Thanks,
Naveen
