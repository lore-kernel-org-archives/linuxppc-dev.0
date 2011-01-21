Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C19DEB7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 20:49:01 +1100 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix some 6xx/7xxx CPU setup functions
References: <1295591723.2148.281.camel__36384.4125684865$1295591768$gmane$org@pasglop>
Date: Fri, 21 Jan 2011 10:48:56 +0100
In-Reply-To: <1295591723.2148.281.camel__36384.4125684865$1295591768$gmane$org@pasglop>
	(Benjamin Herrenschmidt's message of "Fri, 21 Jan 2011 17:35:23
	+1100")
Message-ID: <m31v4660zb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> In absence of good testing I would appreciate a close inspection of the patch
> by different pairs of eyes :-)

Looks good to me.  That broke apparently in 400d221 ("ppc32: make
cur_cpu_spec a single pointer instead of an array"), which changed the
calling convention in call_setup_cpu.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
