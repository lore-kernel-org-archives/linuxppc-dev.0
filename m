Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgX5C8fzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:20 +1000 (AEST)
In-Reply-To: <20180529125738.24271-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 viro@zeniv.linux.org.uk
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: malat@debian.org
Subject: Re: powerpc/ptrace: Use copy_{from, to}_user() rather than open-coding
Message-Id: <40zxgV5SmWz9s7Q@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-29 at 12:57:38 UTC, Michael Ellerman wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> 
> In PPC_PTRACE_GETHWDBGINFO and PPC_PTRACE_SETHWDEBUG we do an
> access_ok() check and then __copy_{from,to}_user().
> 
> Instead we should just use copy_{from,to}_user() which does all that
> for us and is less error prone.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6bcdd2972b9f6ebda9ae5c7075e2d5

cheers
