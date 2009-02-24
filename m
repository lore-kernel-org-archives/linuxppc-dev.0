Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id 7B14FDDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 23:22:25 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: G4 oprofile: variable number of counters
Date: Tue, 24 Feb 2009 14:09:57 +0200
Message-Id: <1235477399-20428-1-git-send-email-opurdila@ixiacom.com>
In-Reply-To: <1233724934.16867.290.camel@pasglop>
References: <1233724934.16867.290.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  static int oprofile_running;
>> -static u32 mmcr0_val, mmcr1_val, mmcr2_val;
>> +static u32 mmcr0_val, mmcr1_val, mmcr2_val, ctrs;
>
>This may be static but it's still a global scope as far as kernel
>symbols are concerned. Care to give it a slightly better name ? num_pmcs
>would probably be already more telling.

Sure. v2 will follow, with s/ctrs/num_pmcs/.

Thanks,
tavi
