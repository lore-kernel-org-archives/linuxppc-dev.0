Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cl56C3zF0PG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:51 +1100 (AEDT)
In-Reply-To: <1518503575-19021-1-git-send-email-harish@linux.vnet.ibm.com>
To: Harish <harish@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Harish <harish@linux.vnet.ibm.com>
Subject: Re: selftests/powerpc: Fix: use ucontext_t instead of struct ucontext
Message-Id: <3zh7ck2DlBz9t6X@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 06:32:55 UTC, Harish wrote:
> With glibc 2.26 'struct ucontext' is removed to improve POSIX
> compliance, which breaks powerpc/alignment_handler selftest.
> Fix the test by using ucontext_t. Tested on ppc, works with older
> glibc versions as well.
> 
> Fixes the following:
> alignment_handler.c: In function ‘sighandler’:
> alignment_handler.c:68:5: error: dereferencing pointer to incomplete type ‘struct ucontext’
>   ucp->uc_mcontext.gp_regs[PT_NIP] += 4;
>      ^~
> 
> Signed-off-by: Harish <harish@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ecdf06e1ea5376bba03c155751f686

cheers
