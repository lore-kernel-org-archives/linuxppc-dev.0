Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E3F5DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 13:44:13 +1000 (EST)
Subject: Re: the printk problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080707132615.f6b6247b.sfr@canb.auug.org.au>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
	<1215393276.8970.36.camel@pasglop>
	<20080707132615.f6b6247b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 13:43:51 +1000
Message-Id: <1215402231.8970.52.camel@pasglop>
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

On Mon, 2008-07-07 at 13:26 +1000, Stephen Rothwell wrote:
> > Did a few tests and it seems to work. I'll stick a patch converting
> > powerpc to use %pS for oops display in -next.
> 
> After you post it to linuxppc-dev and get review comments, of
> course ...

I though I did that already, looks like I didn't. Let me see what went
wrong..

> And after the patch to make %pS work goes in ...

Yup.

Ben.
