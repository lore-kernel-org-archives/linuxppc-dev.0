Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr4lL5j3vzF1CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 15:02:06 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1R3x7rw047692
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:02:04 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gcyfrrwbg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:02:03 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 04:02:00 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 2/4] powerpc/mm/slice: Reduce the stack usage in
 slice_get_unmapped_area
In-Reply-To: <CANashXPZ=KZdixoqCoO7hTy4z7kJLqAst6C-77fg7OdAdfe8EA@mail.gmail.com>
References: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180226140826.11641-3-aneesh.kumar@linux.vnet.ibm.com>
 <CANashXPZ=KZdixoqCoO7hTy4z7kJLqAst6C-77fg7OdAdfe8EA@mail.gmail.com>
Date: Tue, 27 Feb 2018 09:31:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877eqz9j2k.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <nicholas.piggin@gmail.com> writes:

> I had a series which goes significantly further with stack reduction. What
> do you think about just going with that?


I am yet to review that. What I did here is minimum that is required to
get 4PB series compiled.

>
> I wonder if we should switch to dynamically allocating the slice stuff on
> ppc64

-aneesh
