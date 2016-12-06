Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXsNT2nrczDw55
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:36:41 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB66XogC100224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 01:36:39 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2756tfdnya-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 01:36:38 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 16:36:35 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D42302BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:36:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB66aWVr6160454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 17:36:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB66aVSM023918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 17:36:32 +1100
Date: Tue, 6 Dec 2016 12:06:28 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
Message-Id: <20161206063628.GF3450@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By the way, I missed mentioning previously: please use 'powerpc: ' 
prefix for the subject, rather than PPC.


On 2016/12/04 10:25PM, PrasannaKumar Muralidharan wrote:
> Add modsw and moduw instruction emulation support to analyse_instr.

And, it will be better if you can briefly describe what these functions 
do for the benefit of others.

- Naveen
