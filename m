Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxmQb3D49zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 08:06:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33M4O9s064679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 18:06:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29kqbke8ds-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 18:06:08 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 4 Apr 2017 08:06:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33M5teP46858336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 08:06:03 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33M5Vbn012599
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 08:05:31 +1000
Subject: Re: [PATCH] powerpc/misc: fix exported functions that reference the
 TOC
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, "Oliver O'Halloran"
 <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 04 Apr 2017 08:05:05 +1000
In-Reply-To: <87r319vctk.fsf@concordia.ellerman.id.au>
References: <20170403032512.22085-1-oohall@gmail.com>
 <87r319vctk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1491257105.4166.12.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 23:29 +1000, Michael Ellerman wrote:
> The other option would be just to make a rule that anything EXPORT'ed
> must use _GLOBAL_TOC().

Can we enforce that somewhat at build time ?

Cheers,
Ben.
