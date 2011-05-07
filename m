Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8734D100814
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 01:18:24 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
Subject: Re: [PATCH 1/2] ppc: Fix compiler warning in ptrace.c
	[-Wno-array-bounds]
References: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
	<1304777491-7947-2-git-send-email-psomas@cslab.ece.ntua.gr>
Date: Sat, 07 May 2011 17:18:19 +0200
In-Reply-To: <1304777491-7947-2-git-send-email-psomas@cslab.ece.ntua.gr>
	(Stratos Psomadakis's message of "Sat, 7 May 2011 17:11:30 +0300")
Message-ID: <m2oc3eh744.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stratos Psomadakis <psomas@cslab.ece.ntua.gr> writes:

> +CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' -Wno-array-bounds

You need to check first whether the option is valid.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
