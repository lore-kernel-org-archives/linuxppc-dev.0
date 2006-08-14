Return-Path: <mkravetz@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B10467BD8
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 09:41:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7ENfU4C012638
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 19:41:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7ENfUt1278446
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 19:41:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7ENfUQA018826
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 19:41:30 -0400
Date: Mon, 14 Aug 2006 16:41:46 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-ID: <20060814234146.GA17027@w-mikek2.ibm.com>
References: <20060814232144.GG3213@w-mikek2.ibm.com>
	<44E108B0.4070207@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E108B0.4070207@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 14, 2006 at 04:35:12PM -0700, Geoff Levand wrote:
> Mike Kravetz wrote:
> > +config HCALL_STATS
> > +	bool "Hypervisor call instrumentation"
> > +	depends on PPC_PSERIES && DEBUG_FS
> > +	help
> > +	  Adds code to keep track of the number of hypervisor calls made and
> > +	  the amount of time spent in hypervisor calls: both wall time (based
> > +	  on time base) and cpu time (based on PURR).  A directory named
> > +	  hcall_inst is added at the root of the debugfs filesystem.
> 
> Could we keep this more generic and not mention platform specific
> things like PURR?

Not sure if I follow.  PURR will be used/displayed if available.  Time
based statistics will always be available.

I can change the description to make this clear.  Or, are you asking
that this not be mentioned at all?  Based on previous discussions, I
added the ability to display both wall and cpu time if available.

Thanks,
--
Mike
