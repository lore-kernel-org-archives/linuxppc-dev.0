Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swCTs1JFKzDt2d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:18:09 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id fn2so4610096pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 20:18:09 -0700 (PDT)
Date: Fri, 14 Oct 2016 14:18:03 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: make _ASM_NOKPROBE_SYMBOL a noop when KPROBES
 not defined
Message-ID: <20161014141803.14da6ef9@roar.ozlabs.ibm.com>
In-Reply-To: <87wphbdacc.fsf@concordia.ellerman.id.au>
References: <20161013020714.5629-1-npiggin@gmail.com>
 <87wphbdacc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Oct 2016 11:48:35 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > The linker orphan sections error patch caught this  
> 
> You mean with the orphan sections patch applied this breaks the build
> when KPROBES=n right?

Yes. The linker orphan patch got picked up by one of the CI tests after I
posted it, and pointed this out (I obviously didn't test KPROBES=n case).

Thanks,
Nick
