Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D4049DE4E8
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 03:29:45 +1000 (EST)
Date: Mon, 7 Jul 2008 12:29:21 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add PPC_FEATURE_PMU_COMPAT
Message-ID: <20080707172921.GH9594@localdomain>
References: <20080703232001.GB9594@localdomain>
	<A2A80C78-AF10-4FC0-A7E7-CDCACA9AD7E3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A2A80C78-AF10-4FC0-A7E7-CDCACA9AD7E3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Maynard
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Jul 3, 2008, at 6:20 PM, Nathan Lynch wrote:
>
>> Beginning with Power6, there is a set of 32 PMU events which is
>> compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
>> indicates support for this subset.
>>
>> Signed-off-by: Nathan Lynch <ntl@pobox.com>
>> ---
>> arch/powerpc/kernel/cputable.c |    4 ++--
>> include/asm-powerpc/cputable.h |    1 +
>> 2 files changed, 3 insertions(+), 2 deletions(-)
>
> Can you explain what these PMU events are a bit further?

Maynard, can you help out here...?  :)
