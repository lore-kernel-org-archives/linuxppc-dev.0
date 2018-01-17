Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Bt11DpzF0bN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:25:58 +1100 (AEDT)
In-Reply-To: <20180110141946.20127-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Don't print hashed pointers in paca dump
Message-Id: <3zM7Bs3Lbgz9s7h@ozlabs.org>
Date: Thu, 18 Jan 2018 00:25:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-10 at 14:19:46 UTC, Michael Ellerman wrote:
> Remember when the biggest problem we had to worry about was hashed
> pointers, those were the days.
> 
> These were missed in my earlier patch because they don't match "%p",
> but the macro is hiding a "%p", so these all end up being hashed,
> which is not what we want in xmon. Convert them to "%px".
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/2248fade965a5f1ba2a8e6e63f84df

cheers
