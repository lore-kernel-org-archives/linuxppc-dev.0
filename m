Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY7hs3FrGzDvjh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 04:21:49 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6HKfC9107105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:21:46 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2760s4kc26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 12:21:45 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 03:21:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9715B3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 04:21:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6HLfNN46792912
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 04:21:41 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6HLefF013441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 04:21:41 +1100
Date: Tue, 6 Dec 2016 22:51:36 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
 <20161206063628.GF3450@naverao1-tp.localdomain>
 <CANc+2y6hp3-Dw0YJmeGOvgXDZ_Rn9hpyzxrajohsYSnVnGm8OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y6hp3-Dw0YJmeGOvgXDZ_Rn9hpyzxrajohsYSnVnGm8OA@mail.gmail.com>
Message-Id: <20161206172136.GI3450@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/06 10:18PM, PrasannaKumar Muralidharan wrote:
> > By the way, I missed mentioning previously: please use 'powerpc: '
> > prefix for the subject, rather than PPC.
> 
> I will change it. Wondering how they are different.

It's by convention. Maintainers are picky ;)

- Naveen
