Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14B0767A33
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 14:48:50 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1112066934.6809.4.camel@gaston>
References: <1112066934.6809.4.camel@gaston>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 14:48:08 +1000
Message-Id: <1112071689.6809.19.camel@gaston>
Mime-Version: 1.0
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] sleep & cpufreq problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-29 at 13:28 +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Here are a couple of patches against current linus bk (one was already
> posted to this list) that should fix a number issues related to sleep
> and wakeup, especially in conjunction with cpufreq transitions.
> 
> Please test and let me know if it fixes a problem you had, it adds a new
> problem, or it has no effect, stuff still doesn't work (if it used to
> work and still work, no need to bug me).
> 
> Thanks !
> 
> Patches are at:
> 
> http://gate.crashing.org/~benh/ppc32-pmac-sleep-fix.diff
> http://gate.crashing.org/~benh/ppc32-cpufreq-gpio-off.diff

I just updated the second patch, so if you got it since my last email,
please d/l it again.

Ben.
