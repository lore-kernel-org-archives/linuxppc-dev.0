Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16CA267D08
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 07:36:58 +1100 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
In-Reply-To: <4545E38B.5010702@ubuntu.com>
References: <45419F79.2020300@ubuntu.com>
	<1162177334.25682.144.camel@localhost.localdomain>
	<4545E38B.5010702@ubuntu.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 07:36:50 +1100
Message-Id: <1162240610.25682.182.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-30 at 12:35 +0100, Fabio Massimo Di Nitto wrote:
> Benjamin Herrenschmidt wrote:
> > Does that patch fixes it ?
> > 
> 
> tested with kernel .17 and headers from .19 and the build hangs. Still tons of
> Zl processes around.
> 
> On the note building with kernel .19 and .19 headers it all goes smooth.

Ok, so there's a different issue from what I've found. You haven't by
chance noted what those processes are (which test case typically) ?
Also, there's a sysrq to get a backtrace of all pending processes,
though I don't remember which one off the top of my mind, might be
useful to have a look though.

Ben.
