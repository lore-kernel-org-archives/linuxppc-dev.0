Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA81C1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 22:41:44 +1100 (AEDT)
In-Reply-To: <1444724227-24251-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: thuth@redhat.com
Subject: Re: powerpc/cell: Drop CONFIG_TUNE_CELL in favour of CONFIG_CELL_CPU
Message-Id: <20151021114144.8F7F2140DB4@ozlabs.org>
Date: Wed, 21 Oct 2015 22:41:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-13-10 at 08:17:07 UTC, Michael Ellerman wrote:
> The TUNE_CELL option allows you to build a kernel that runs on multiple
> CPUs but is tuned (ie. optimised) to run on Cell CPUs. Now days no one
> is building a distro in that fashion, and any users who are building
> custom kernels for their Cell machines are better off building with
> CONFIG_CELL_CPU, which builds a kernel that only runs on Cell and
> therefore can be optimised even more aggresively.
> 
> Dropping the option also avoids confusing other users, who are presented
> with an option to tune for Cell when they are not building for a Cell
> CPU at all.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/bed08b7e1fa41eac214acb17

cheers
