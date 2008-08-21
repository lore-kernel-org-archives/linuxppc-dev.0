Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EE3B3DF318
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:03:48 +1000 (EST)
Date: Thu, 21 Aug 2008 14:03:46 -0700 (PDT)
Message-Id: <20080821.140346.236252915.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] math-emu: Fix compiler warnings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
References: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 21 Aug 2008 07:50:20 -0500

> Fix warnings of the form:
> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f1' may be used uninitialized in this function
> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f0' may be used uninitialized in this function
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

You should look at the compiler options we use on sparc to build this
stuff :-)

EXTRA_CFLAGS = -Iinclude/math-emu -w
