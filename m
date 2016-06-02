Return-Path: <hughd@google.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL9hP6LXVzDqg3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:12:53 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id bz2so6522405pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 08:12:53 -0700 (PDT)
Date: Thu, 2 Jun 2016 08:12:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
In-Reply-To: <alpine.LSU.2.11.1605310902480.7816@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1606020807590.9580@eggly.anvils>
References: <201605270629.u4R6OCLx014831@mx0a-001b2d01.pphosted.com>
 <alpine.LSU.2.11.1605300903270.1076@eggly.anvils>
 <1464647262.3078.219.camel@kernel.crashing.org>
 <alpine.LSU.2.11.1605310902480.7816@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 May 2016, Hugh Dickins wrote:
> 
> But all my evidence so far is that it is now right: I'll continue
> testing v4.6+fix on a couple of loads until this evening: all is
> well so far.  And then switch to testing v4.5+fix on those loads
> for another day and a half.

I'm glad to confirm: your patch to htab_convert_pte_flags() fixes all
the elusive sigsegv issues I was seeing under load on v4.5 and v4.6.
Thank you!

Hugh
