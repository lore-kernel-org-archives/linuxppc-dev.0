Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMJht37jkzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 19:33:02 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1D8ShM3089004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 03:32:59 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28j5xv0tpg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 03:32:59 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 14:02:56 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BFA6EE005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:04:23 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1D8Wq5135389602
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:02:52 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1D8WpnB015236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:02:52 +0530
Date: Mon, 13 Feb 2017 14:02:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mhiramat@kernel.org, ananth@linux.vnet.ibm.com, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <87vasizp8u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vasizp8u.fsf@concordia.ellerman.id.au>
Message-Id: <20170213083250.GE7674@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/10 02:41PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > kprobe_exceptions_notify() is not used on some of the architectures such
> > as arm[64] and powerpc anymore. Introduce a weak variant for such
> > architectures.
> 
> I'll merge patch 1 & 3 via the powerpc tree for v4.11.
> 
> You can then send patch 2 to the arm guys after -rc1, or for 4.12.

Sure, thanks!

- Naveen
