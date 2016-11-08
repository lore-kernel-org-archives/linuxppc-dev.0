Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCxHc1qRwzDvR0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 04:33:47 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8HSvlI138667
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2016 12:33:45 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26kgauufjb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 12:33:45 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 9 Nov 2016 03:33:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4F1F22BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 04:33:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA8HXf4W19333356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 04:33:41 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA8HXexK012057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 04:33:41 +1100
Date: Tue, 8 Nov 2016 23:03:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
References: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
 <8760nyl9e9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760nyl9e9.fsf@concordia.ellerman.id.au>
Message-Id: <20161108173338.GO6949@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/08 06:26PM, Michael Ellerman wrote:
> Can you guys let me know if Hugh's fix works for you?
> 
> https://patchwork.ozlabs.org/patch/691753/

Yes, that works for me too.

- Naveen
