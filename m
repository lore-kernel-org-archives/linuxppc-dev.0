Return-Path: <srs0=xjey=aa=linux.vnet.ibm.com=gpiccoli@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj4zr256BzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:48:08 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xj4zr1R23z8tQ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 22:48:08 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xj4zq4Kjwz9sNn
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 22:48:06 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UCjmQ2079542
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 08:48:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnrqwu7rn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 08:48:02 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 08:47:44 -0400
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 "dougmill@us.ibm.com" <dougmill@us.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 09:47:34 -0300
MIME-Version: 1.0
In-Reply-To: <87shg91fgc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <b94ec054-c08f-18a7-8dfb-ef8989f6c129@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2017 08:07 AM, Michael Ellerman wrote:
>[...]
> OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
> flip it back to being a module.
> 

OK, I'll be tuned! Thanks


> I think the majority of machines that have one of these adapters will be
> using it for their root disk, so I think the slow initialisation is just
> something we have to suffer.
> 
> cheers
> 
