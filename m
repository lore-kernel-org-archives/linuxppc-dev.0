Return-Path: <psomas@ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id 0AC4B1007DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 01:57:17 +1000 (EST)
Message-ID: <4DC56BD5.60109@ece.ntua.gr>
Date: Sat, 07 May 2011 18:57:09 +0300
From: Stratos Psomadakis <psomas@ece.ntua.gr>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] ppc: Fix compiler warning in ptrace.c
	[-Wno-array-bounds]
References: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>	<1304777491-7947-2-git-send-email-psomas@cslab.ece.ntua.gr>
	<m2oc3eh744.fsf@igel.home>
In-Reply-To: <m2oc3eh744.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2011 06:18 PM, Andreas Schwab wrote:
> Stratos Psomadakis <psomas@cslab.ece.ntua.gr> writes:
>
>> +CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' -Wno-array-bounds
> You need to check first whether the option is valid.
>
> Andreas.
>
I resent the patch, with $(call cc-option) to check if GCC supports the
option. Is it ok?

Thx.

-- 
Stratos Psomadakis
<psomas@ece.ntua.gr>
