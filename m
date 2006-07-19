Return-Path: <mkravetz@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCF6D67B89
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 13:36:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6J3a1kl031644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:36:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6J3a06G264404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:36:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6J3a0v8010807
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:36:00 -0400
Date: Tue, 18 Jul 2006 20:36:18 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060719033618.GA3944@monkey.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<17597.19430.983453.919592@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17597.19430.983453.919592@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 07:00:22AM +1000, Paul Mackerras wrote:
> Mike Kravetz writes:
> > A small update from the last version.  By popular demand, both
> > wall time (mftb) and cpu cycles(PURR) are collected for each call.
> > It is interesting to see these two values side by side in the
> > output files.
> 
> Did you see the patch from Anton that I posted a week or so ago, which
> reduces the number of plpar_hcall_* functions?  I'd rather the
> instrumentation stuff was based on that.

Agreed.  I missed the patch from last week, but saw the one from Anton
that was posted today.  Future instrumentation patches will assume this
change.

> My other comment is this: wouldn't it actually turn out simpler if we
> read the timebase (and PURR, if we really want to do that too) in the
> assembly code that implements plpar_hcall_*?

I'll give that a try.  My assembly skills are a bit rusty, so it may
take a little longer to produce something.

-- 
Mike
