Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SX0S4CzF37Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
In-Reply-To: <20180821021428.23377-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: Don't select the cpufreq governors
Message-Id: <42G3SV6J26z9sCq@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-21 at 02:14:28 UTC, Joel Stanley wrote:
> Deciding wich govenors should be built into the kernel can be left to
> users to configure.
> 
> Fixes: 81f359027a3a ("cpufreq: powernv: Select CPUFreq related Kconfig options for powernv")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0dc0f8618e87f1b2c7f04b977fda1

cheers
