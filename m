Return-Path: <roland@redhat.com>
Received: from QMTA04.westchester.pa.mail.comcast.net
	(qmta04.westchester.pa.mail.comcast.net [76.96.62.40])
	by ozlabs.org (Postfix) with ESMTP id AAE77DDFAB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 05:34:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
In-Reply-To: Paul Mackerras's message of  Tuesday, 13 May 2008 21:55:22 +1000
	<18473.33194.781010.826872@cargo.ozlabs.ibm.com>
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
	<20080504231207.8377E26FA08@magilla.localdomain>
	<18473.33194.781010.826872@cargo.ozlabs.ibm.com>
Message-Id: <20080513193350.8B90C26F8D4@magilla.localdomain>
Date: Tue, 13 May 2008 12:33:50 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So it looks like we need to define a new feature bit to mean "supports
> block-step".  Is this something that userspace will expect to be told
> about via the AT_HWCAP entry in the aux vector?

I don't care to have userland know about it.  I'm just concerned with the
arch_has_block_step() definition being right.  But, you did previously tell
me that userland can set its own MSR_SE via sigreturn or setcontext or
something.  If it can set its own MSR_BE the same way, then perhaps
userland wants to know.


Thanks,
Roland
