Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 9336767B5A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 03:33:51 +1000 (EST)
Date: Fri, 9 Jun 2006 12:33:26 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] powersave_nap cleanup
Message-ID: <20060609173326.GA8934@localdomain>
References: <20060526140227.GE8934@localdomain>
	<17545.15326.767523.342562@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17545.15326.767523.342562@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Nathan Lynch writes:
> 
> > Rename machdep_calls.power_save to machdep_calls.powersave_nap to make
> > more apparent the connection with the powersave_nap sysctl.
> 
> Hmmm, it's possibly a bit confusing to have a variable and a function
> with the same name...

Heh, I thought you had suggested doing that, maybe I misunderstood.

So, what to do?  Leave the machdep_calls.power_save name as it is?
