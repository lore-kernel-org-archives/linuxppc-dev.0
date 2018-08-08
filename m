Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwK0kPczDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:53 +1000 (AEST)
In-Reply-To: <20180724140346.10575-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Add a checkpatch wrapper with our preferred settings
Message-Id: <41ltwH64MVz9s89@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-24 at 14:03:46 UTC, Michael Ellerman wrote:
> This makes it easy to run checkpatch with settings that we have agreed
> on (bwhahahahah).
> 
> Usage is eg:
> 
>   $ ./arch/powerpc/tools/checkpatch.sh -g origin/master..
> 
> To check all commits since origin/master.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/7cd129b4b5370030a5c0b8031a54b2

cheers
