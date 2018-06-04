Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxg82CTGzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:00 +1000 (AEST)
In-Reply-To: <20180514130316.23855-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: thgarnie@google.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [1/2] powerpc: Rename thread_struct.fs to addr_limit
Message-Id: <40zxg609Blz9ryk@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 13:03:15 UTC, Michael Ellerman wrote:
> It's called 'fs' for historical reasons, it's named after the x86 'FS'
> register. But we don't have to use that name for the member of
> thread_struct, and in fact arch/x86 doesn't even call it 'fs' anymore.
> 
> So rename it to 'addr_limit', which better reflects what it's used
> for, and is also the name used on other arches.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/ba0635fcbe8c1ce83523c1ec797538

cheers
