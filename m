Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlSPQ3y0tzDqxv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:28:42 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u676O9e2103202
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:28:40 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmdtyq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:28:40 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Jul 2016 16:28:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3CA762CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:28:34 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u676SYa5262596
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:28:34 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u676SXC9004289
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:28:33 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 06/14] powerpc/powernv: Add support for the cxl kernel api
 on the real phb
In-reply-to: <577D420A.9060806@linux.vnet.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-7-git-send-email-imunsie@au.ibm.com>
 <577D420A.9060806@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2016 16:28:32 +1000
Message-Id: <1467872875-sup-9587@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-07-06 19:38:18 +0200:
> 
> > +    /* No special handling for cxl function: */
> > +    if (PCI_FUNC(dev->devfn) == 0)
> > +        return true;
> 
> I believe that is the first time we're getting a hint of the black magic 
> which is going to occur when the card is switched to cxl mode and the 
> appearance of a new pci function. I think a general comment explaining 
> it is needed somewhere. In this patch or a later one. Also "peer model" 
> is used several times in the commit messages, though it's not clear to 
> the novice what it really means.
> 
> At this point of the review, I was a bit overwhelmed by all the new 
> APIs, wondering how everything would end up working together. By the 
> last patch, it's understandable, but a few extra comments would help.
> For the vPHB model, pretty much all the relevant code is in one file, 
> which helps grabbing the full picture. But here it's spread between the 
> phb platform code and the cxl driver.
> 
>    Fred

Ok, will see what I can to to clarify this.

-Ian
