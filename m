Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 113C9DDEED
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 08:06:02 +1000 (EST)
Message-Id: <A8423953-8153-48AD-B8C4-A6C0CBBABFB8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080708200137.GN9594@localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] Add PPC_FEATURE_PSERIES_PMU_COMPAT
Date: Tue, 8 Jul 2008 17:05:51 -0500
References: <20080703232001.GB9594@localdomain>
	<20080708200137.GN9594@localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 8, 2008, at 3:01 PM, Nathan Lynch wrote:

> Background from Maynard Johnson:
> As of POWER6, a set of 32 common events is defined that must be
> supported on all future POWER processors.  The main impetus for this
> compat set is the need to support partition migration, especially from
> processor P(n) to processor P(n+1), where performance software that's
> running in the new partition may not be knowledgeable about processor
> P(n+1).  If a performance tool determines it does not support the
> physical processor, but is told (via the  
> PPC_FEATURE_PSERIES_PMU_COMPAT
> bit) that the processor supports the notion of the PMU compat set,
> then the performance tool can surface just those events to the user
> of the tool.
>
> PPC_FEATURE_PSERIES_PMU_COMPAT indicates that the PMU supports at
> least this basic subset of events which is compatible across POWER
> processor lines.
>
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> ---

So is PMU here performance monitor unit?  I think that was part of my  
confusion earlier.  I was thinking Power Mgmt Unit (like on Apple HW).

I hate make the name longer, but PPC_FEATURE_PSERIES_PERFMON_COMPAT  
would probably be clearer.

- k
