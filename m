Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 11010DE866
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 03:18:18 +1000 (EST)
Date: Mon, 7 Jul 2008 12:17:49 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Add PPC_FEATURE_PMU_COMPAT
Message-ID: <20080707171749.GG9594@localdomain>
References: <20080703232001.GB9594@localdomain>
	<9C67179C-12C2-430C-B3FB-07A80DBB7324@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C67179C-12C2-430C-B3FB-07A80DBB7324@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Jul 3, 2008, at 6:20 PM, Nathan Lynch wrote:
>
>> Beginning with Power6, there is a set of 32 PMU events which is
>> compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
>> indicates support for this subset.
>
> The PMU isn't, as far as I know, part of the architecture, it's up to  
> each implementation to do as it pleases. Right? So this should probably 
> be named less generic.

Yeah, you're right.  Will change it to PSERIES_PMU_COMPAT or similar.
