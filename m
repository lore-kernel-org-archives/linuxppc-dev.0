Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqd3PwfzF0Vy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:05 +1100 (AEDT)
In-Reply-To: <20170112035413.26544-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Use octal numbers for file permissions
Message-Id: <3zPxqd27Y9z9sBW@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-12 at 03:54:13 UTC, Russell Currey wrote:
> Symbolic macros are unintuitive and hard to read, whereas octal constants
> are much easier to interpret.  Replace macros for the basic permission
> flags (user/group/other read/write/execute) with numeric constants
> instead, across the whole powerpc tree.
> 
> Introducing a significant number of changes across the tree for no runtime
> benefit isn't exactly desirable, but so long as these macros are still
> used in the tree people will keep sending patches that add them.  Not only
> are they hard to parse at a glance, there are multiple ways of coming to
> the same value (as you can see with 0444 and 0644 in this patch) which
> hurts readability.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57ad583f2086d55ada284c54bfc440

cheers
