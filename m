Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQ5J84Wh6zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 10:08:56 +1000 (AEST)
Message-ID: <1465430936.27819.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/nohash: Fix build break with 4K pages
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Date: Thu, 09 Jun 2016 10:08:56 +1000
In-Reply-To: <87wplz20t3.fsf@skywalker.in.ibm.com>
References: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
 <87wplz20t3.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 20:19 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
> > allocating fragments" renamed page_table_free() to pte_fragment_free().
> > One occurrence was mistyped as pte_fragment_fre().
> > 
> > This only breaks the nohash 4K page build, which is not the default or
> > enabled in any defconfig.
> 
> Can you share the .config. I will add it to the build test.

It was a randconfig, it still doesn't build even with this patch:

  http://kisskb.ellerman.id.au/kisskb/buildresult/12705111/

cheers
