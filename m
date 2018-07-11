Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft72J13zF35P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:15 +1000 (AEST)
In-Reply-To: <1530019213-2347-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [v3,1/2] selftests/powerpc: Fix strncpy usage
Message-Id: <41Qft64cJhzB4Mf@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-26 at 13:20:12 UTC, Breno Leitao wrote:
> There is a buffer overflow in dscr_inherit_test.c test. In main(), strncpy()'s
> third argument is the length of the source, not the size of the destination
> buffer, which makes strncpy() behaves like strcpy(), causing a buffer overflow
> if argv[0] is bigger than LEN_MAX (100).
> 
> This patch maps 'prog' to the argv[0] memory region, removing the static
> allocation and the LEN_MAX size restriction.
> 
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Segher Boessenkool <segher@kernel.crashing.org>
> CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/09a61e894ac852fb063ee0b54fc513

cheers
