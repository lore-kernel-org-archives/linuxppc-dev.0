Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlz40rdVzDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:24 +1100 (AEDT)
In-Reply-To: <1508860129-28365-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/mm: Add a CONFIG option to choose if radix is used by
 default
Message-Id: <3yWlyz5hzyz9sPt@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-24 at 15:48:49 UTC, Michael Ellerman wrote:
> Currently if the hardware supports the radix MMU we will use
> it, *unless* "disable_radix" is passed on the kernel command line.
> 
> However some users would like the reverse semantics. ie. The kernel
> uses the hash MMU by default, unless radix is explicitly requested on
> the command line.
> 
> So add a CONFIG option to choose whether we use radix by default or
> not, and expand the disable_radix command line option to allow
> "disable_radix=no" which *enables* radix.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1fd6c02207107c8892219dacef01de

cheers
