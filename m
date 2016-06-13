Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rShVj5J4XzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:42:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5D5YESE052345
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 01:42:02 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gcyccn4q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 01:42:02 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 15:42:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2C4963578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:41:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5D5fvhv4850100
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:41:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5D5fuBS020789
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:41:56 +1000
Date: Mon, 13 Jun 2016 11:10:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, matt@ozlabs.org, kda@linux-powerpc.org,
 paulus@samba.org, ast@fb.com, daniel@iogearbox.net, ananth@in.ibm.com
Subject: Re: [PATCH 0/6] eBPF JIT for PPC64
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610.224755.1614979708956751311.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610.224755.1614979708956751311.davem@davemloft.net>
Message-Id: <20160613054055.GV18654@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/10 10:47PM, David Miller wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Date: Tue,  7 Jun 2016 19:02:17 +0530
> 
> > Please note that patch [2] is a pre-requisite for this patchset, and is
> > not yet upstream.
>  ...
> > [1] http://thread.gmane.org/gmane.linux.kernel/2188694
> > [2] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/96514
> 
> Because of #2 I don't think I can take this directly into the networking
> tree, right?
> 
> Therefore, how would you like this to be merged?

Hi David,
Thanks for asking. Yes, I think it is better to take this through the 
powerpc tree as all the changes are contained within arch/powerpc, 
unless Michael Ellerman feels differently.

Michael?


Regards,
Naveen
