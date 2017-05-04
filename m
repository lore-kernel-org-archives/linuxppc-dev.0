Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJNBm4cs3zDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 15:00:32 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444xNGC053667
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 01:00:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7wnug6mf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 01:00:29 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 15:00:27 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4450G5952560076
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 15:00:24 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444xqhs021372
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:59:52 +1000
Date: Thu, 4 May 2017 10:29:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 0/3] powerpc: build out kprobes blacklist
References: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1493274843.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170504045934.GB9733@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/27 02:06PM, Naveen N. Rao wrote:
> v2 changes:
> - Patches 3 and 4 from the previous series have been merged.
> - Updated to no longer blacklist functions involved with stolen time
>   accounting.
> 
> v1:
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg117514.html
> --
> This is the second in the series of patches to build out an appropriate
> kprobes blacklist. This series blacklists system_call() and functions
> involved when handling the trap itself. Not everything is covered, but
> this is the first set of functions that I have tested with. More
> patches to follow once I expand my tests.
> 
> I have converted many labels into private -- these are labels that I
> felt are not necessary to read stack traces. If any of those are
> important to have, please let me know.

Hi Anton,
Can you please take a look at this series and let me know if you any 
concerns, especially around some of the labels that I have made private?

Thanks,
Naveen
