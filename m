Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYJpP1Nd3zDqPH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:12:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21F4hCk105670
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:12:26 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28wxrbew9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 10:12:26 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 20:42:23 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1A3E7E0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 20:44:05 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21FBEln12058624
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:41:14 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21FCIHt018141
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:42:19 +0530
Date: Wed, 1 Mar 2017 20:42:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] perf: probe: generalize probe event file open
 routine
References: <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
 <b580465c7a4dcd5d3b40fdf8568e6be45d0a6333.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170225014601.eb2cec0b4ea94790a2f11181@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225014601.eb2cec0b4ea94790a2f11181@kernel.org>
Message-Id: <20170301151217.GM4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/25 01:46AM, Masami Hiramatsu wrote:
> On Thu, 23 Feb 2017 17:07:23 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > ...into a generic function for opening trace files.
> 
> Even if it repeats subject, please write complete description...

Agh, ok sure. I will try to curb my urge to not type too much :)

> 
> Patch itself is OK to me.

Thanks for the review on this series!

- Naveen
