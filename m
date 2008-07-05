Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id F1563DDE16
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 15:10:45 +1000 (EST)
Message-Id: <9C67179C-12C2-430C-B3FB-07A80DBB7324@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080703232001.GB9594@localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] Add PPC_FEATURE_PMU_COMPAT
Date: Sat, 5 Jul 2008 00:10:27 -0500
References: <20080703232001.GB9594@localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jul 3, 2008, at 6:20 PM, Nathan Lynch wrote:

> Beginning with Power6, there is a set of 32 PMU events which is
> compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
> indicates support for this subset.

The PMU isn't, as far as I know, part of the architecture, it's up to  
each implementation to do as it pleases. Right? So this should  
probably be named less generic.


-Olof
