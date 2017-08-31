Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgKx5yBHzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:49 +1000 (AEST)
In-Reply-To: <1473160910-20247-1-git-send-email-yamada.masahiro@socionext.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmicy@gmail.com>, Kees Cook <keescook@chromium.org>,
 kvm@vger.kernel.org, <rkrcmar@redhat.com>, Geoff Levand <geoff@infradead.org>,
 Simon Guo <wei.guo.simon@gmail.com>, Khem Raj <raj.khem@gmail.com>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Cyril Bur <cyrilbur@gmail.com>, Alexander Graf <agraf@suse.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: powerpc: squash lines for simple wrapper functions
Message-Id: <3xjgKx4rsNz9t16@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-06 at 11:21:50 UTC, Masahiro Yamada wrote:
> Remove unneeded variables and assignments.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7f2462acb6a995f2b0005192c0ba8e

cheers
