Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05DEB1A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:51:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Jun 2015 08:21:15 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DF1B6394005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 08:21:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5H2pBUo37552368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 08:21:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5H1q6HC019988
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 07:22:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/2] powerpc/mm: Change the swap encoding in pte.
In-Reply-To: <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2015 08:21:10 +0530
Message-ID: <87616ngi8x.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:


Hi Scott,

> Current swap encoding in pte can't support large pfns
> above 4TB. Change the swap encoding such that we put
> the swap type in the PTE bits. Also add build checks
> to make sure we don't overlap with HPTEFLAGS.
>

Can you please review this w.r.t 64bit booke ? 

-aneesh
