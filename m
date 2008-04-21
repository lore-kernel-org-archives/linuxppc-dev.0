Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEC73DDEF5
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 19:24:36 +1000 (EST)
Subject: Re: [PATCH 2.6.26?] Raise the upper limit of NR_CPUS.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1208768706.9955.9.camel@concordia>
References: <20080418053349.GE20457@bakeyournoodle.com>
	<1208743427.10486.2.camel@pasglop> <1208768706.9955.9.camel@concordia>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 19:24:14 +1000
Message-Id: <1208769854.9640.24.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-21 at 19:05 +1000, Michael Ellerman wrote:
> 
> Tony, you should NAK Ben tomorrow after lunch if you know what I
> mean :)

Should I hide ? :-)

> > You must NEVER manipulate kernel globals from prom_init.c. The fact
> that
> > prom_init is linked with the kernel is an "accident" which may
> change.
> 
> A very long running accident, we should really look at fixing it some
> time.

Patch welcome :-)

Historically, it used to manipulate some kernel data structures, but we
fixed all of that when we introduced the flat DT model.

> > Your scheme would break among others with kexec or non-OF
> bootloaders
> 
> I talked to Tony about it this morning and we came up with a scheme
> that
> should work for all cases.

Excellent.

Cheers,
Ben.
