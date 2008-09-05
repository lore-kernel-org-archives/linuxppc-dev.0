Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3ECABDDEEF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 19:32:14 +1000 (EST)
Subject: Re: 2.6.27-rc5-mm1 mystery trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080904214115.2b4ab5fd.akpm@linux-foundation.org>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<1220586164.4879.116.camel@pasglop>
	<20080904204957.04a420ac.akpm@linux-foundation.org>
	<1220589401.4879.125.camel@pasglop>
	<20080904214115.2b4ab5fd.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 19:31:36 +1000
Message-Id: <1220607096.4879.163.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > A 64-bit binary on a 64-bit machine Should Just Work.  Maybe that's
> > > me being simplistic.
> > 
> > But is it a 64 bits binary ? 
> > 
> 
> vmlinux?  Yup.  According to file(1).

No, I'm talking about gdb :-0

IE. If it's a 32 bits gdb variant that cannot do 64 bits.. then it's
stuffed.

Is there a gdb64 binary somewhere ? Some distro have that.

Cheers,
Ben.
