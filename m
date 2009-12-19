Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 67E9BB6F16
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 21:11:34 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/6 v5] CPU probe/release files
References: <4AE8ADCF.6090104@austin.ibm.com>
	<4AE8B072.1070603@austin.ibm.com> <m2oclw9wt4.fsf@igel.home>
	<1261212415.2173.94.camel@pasglop>
Date: Sat, 19 Dec 2009 11:11:29 +0100
In-Reply-To: <1261212415.2173.94.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Sat, 19 Dec 2009 19:46:55 +1100")
Message-ID: <m26383jmsu.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Nathan, the problem is that the above wlil define ARCH_CPU_PROBE_RELEASE
> for any powerpc platform that has HOTPLUG_CPU. So a kernel that doesn't
> have pSeries support but has hotplug CPU will have a problem, though for
> some reason none of my test configs triggered it (I'll have to check why
> next week).

Perhaps you didn't enable CONFIG_SUSPEND.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
