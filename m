Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Mc913cwKzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 00:11:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w66E8axO082258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jul 2018 10:11:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k285uw1qk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Jul 2018 10:11:30 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 6 Jul 2018 15:11:27 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
In-Reply-To: <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
 <87k2sic6pw.fsf@linux.vnet.ibm.com>
 <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
Date: Fri, 06 Jul 2018 19:41:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8lch2t2.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hi Aneesh,
>
> Are you still working on support for KASan for ppc64 ?
>

Haven't got time to work on this. The hash memory layout makes it
a bit complicated to implement this.

-aneesh
