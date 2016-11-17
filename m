Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKNdW6h1mzDvs1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 01:23:11 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHEItKH017198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:23:09 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26sbr9rdyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 09:23:08 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 19:53:04 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D90B7125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 19:53:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAHEN2gV23265370
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 19:53:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAHEN02T002736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 19:53:01 +0530
Date: Thu, 17 Nov 2016 19:52:58 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: crypto/vmx: various build fixes
References: <20161116151146.15720-1-naveen.n.rao@linux.vnet.ibm.com>
 <87inrnx70z.fsf@concordia.ellerman.id.au>
 <20161117130311.GA1839@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117130311.GA1839@gondor.apana.org.au>
Message-Id: <20161117142258.GD4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/17 09:03PM, Herbert Xu wrote:
> On Thu, Nov 17, 2016 at 11:51:56AM +1100, Michael Ellerman wrote:
> > 
> > Crypto patches usually have a subject like:
> > 
> > crypto: vmx - Various build fixes

Ok.

> >
> > But maybe Herbert can fix it up for you when he applies this.
> 
> Sure I can fix it up.

Thanks,
- Naveen
