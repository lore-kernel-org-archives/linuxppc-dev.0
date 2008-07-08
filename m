Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 72F9DDDEED
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 08:34:56 +1000 (EST)
Date: Tue, 8 Jul 2008 17:30:22 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] Add PPC_FEATURE_PSERIES_PMU_COMPAT
Message-ID: <20080708223022.GO9594@localdomain>
References: <20080703232001.GB9594@localdomain>
	<20080708200137.GN9594@localdomain>
	<A8423953-8153-48AD-B8C4-A6C0CBBABFB8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A8423953-8153-48AD-B8C4-A6C0CBBABFB8@kernel.crashing.org>
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

Kumar Gala wrote:
>
> So is PMU here performance monitor unit?  I think that was part of my  
> confusion earlier.  I was thinking Power Mgmt Unit (like on Apple HW).

Yes, PMU means performance monitor unit in the context of pseries.


> I hate make the name longer, but PPC_FEATURE_PSERIES_PERFMON_COMPAT  
> would probably be clearer.

Okay.
