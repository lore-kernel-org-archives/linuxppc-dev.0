Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail8-fra-R.bigfish.com (mail-fra.bigfish.com [62.209.45.166])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 026B3679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 09:35:19 +1000 (EST)
Message-ID: <44E108B0.4070207@am.sony.com>
Date: Mon, 14 Aug 2006 16:35:12 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
References: <20060814232144.GG3213@w-mikek2.ibm.com>
In-Reply-To: <20060814232144.GG3213@w-mikek2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz wrote:

> +config HCALL_STATS
> +	bool "Hypervisor call instrumentation"
> +	depends on PPC_PSERIES && DEBUG_FS
> +	help
> +	  Adds code to keep track of the number of hypervisor calls made and
> +	  the amount of time spent in hypervisor calls: both wall time (based
> +	  on time base) and cpu time (based on PURR).  A directory named
> +	  hcall_inst is added at the root of the debugfs filesystem.

Could we keep this more generic and not mention platform specific
things like PURR?

-Geoff
