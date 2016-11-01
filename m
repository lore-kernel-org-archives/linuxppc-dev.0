Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7JTZ4KBZzDsrd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 15:41:22 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so4676239pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 21:41:22 -0700 (PDT)
Date: Tue, 1 Nov 2016 15:41:12 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: fpr save/restore function cleanups
Message-ID: <20161101154112.1516b5cb@roar.ozlabs.ibm.com>
In-Reply-To: <20161101042219.25587-1-npiggin@gmail.com>
References: <20161101042219.25587-1-npiggin@gmail.com>
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

On Tue,  1 Nov 2016 15:22:19 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> The powerpc64 linker generates fpr save/restore functions on-demand,
> placing them in the .sfpr section. So remove the explicitly coded ones
> from the 64 build.
> 
> Have 32-bit put save/restore functions into .sfpr section rather than
> .text, to match 64-bit.
> 
> And explicitly have the linker script place the section rather than
> leaving it as orphan.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> I tested this with 64-bit optimize-for-size build with modules,
> and that works okay.

No I didn't, it's broken. I'll send an update shortly.

Thanks,
Nick
