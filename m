Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1CA11A1059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:02 +1000 (AEST)
In-Reply-To: <1434338719-8416-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: powerpc: Set the correct kernel taint on machine check errors.
Message-Id: <20150707103802.DA52B1402BE@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-15-06 at 03:25:19 UTC, Daniel Axtens wrote:
> This means the 'M' flag will work properly when the kernel prints a backtrace.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=27ea2c420cad57386c25668cb9a9f0f082635586

cheers
