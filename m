Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 368CD1A0D9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 18:49:46 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 02:49:44 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7BF546E8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 02:36:33 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1T7nfU133030364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 07:49:42 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1T7nfhh005045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 02:49:41 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
In-Reply-To: <1456713374.32505.55.camel@kernel.crashing.org>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456713374.32505.55.camel@kernel.crashing.org>
Date: Mon, 29 Feb 2016 13:19:37 +0530
Message-ID: <87bn70q7la.fsf@linux.vnet.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2016-02-26 at 08:50 +0530, Aneesh Kumar K.V wrote:
>> _PAGE_PRIV means the page can be accessed only by kernel. This is
>> done
>> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
>> pages are now makred by clearing _PAGE_PRIV bit.
>
> Very minor nit: It's not clear that PRIV means PRIVILEGED (rather than
> PRIVATE). Can you spell it out completely instead ? I like things being
> self-describing ;-)
>

Ok, I will update this

Thanks,
-aneesh
