Return-Path: <srs0=zzoi=ab=linux.vnet.ibm.com=stewart@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjcyn6QpzzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:49:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xjcyn4wHQz8t8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:49:05 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xjcyn0SdRz9s7c
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2017 19:49:04 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7V9ht6T042346
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2017 05:49:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cpdd6g070-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2017 05:49:02 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 05:49:01 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <87shg91fgc.fsf@concordia.ellerman.id.au>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
 <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
 <87shg91fgc.fsf@concordia.ellerman.id.au>
Date: Thu, 31 Aug 2017 19:48:53 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3q0hxtm.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> OK. So maybe when the petitboot kernel moves up to 4.14 they may want to
> flip it back to being a module.

Yeah. We tend to keep all RAID adapters as modules because they almost
all uniquely try to undo all boot time optimization done by anybody,
anywhere, ever.

> I think the majority of machines that have one of these adapters will be
> using it for their root disk, so I think the slow initialisation is just
> something we have to suffer.

It does seem that way currently.

-- 
Stewart Smith
OPAL Architect, IBM.
