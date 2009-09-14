Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A78B1B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 18:00:36 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 158F8DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 18:00:35 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
In-Reply-To: <1252873548.8375.73.camel@pasglop>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 18:00:27 +1000
Message-Id: <1252915227.8375.118.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-14 at 06:25 +1000, Benjamin Herrenschmidt wrote:
> > > .../...
> > > 
> > > > Something is totally messed up here.
> > > 
> > > Could it be that we don't handle R_PPC64_ADDR16_* relocs in
> > > arch/powerpc/kernel/modules/module_64.c ?
> > > 
> > > Sachin, do you see a bunch of "Unknown ADD relocation" in your dmesg ?
> > 
> > Ben,
> > 
> > The thing is, this is kernel proper. This code is in entry_64.S not in
> > the module code.
> 
> Argh... indeed.
> 
> Sachin, can you give me more details on how you built that kernel ? (or
> give them again in case I missed them the first time around :-), ie,
> what toolchain, options, etc... or even better, give me remote access to
> the build host ?

Ok, got access and had a quick look... seems to be a toolchain problem
to me. I'll investigate more tomorrow.

Cheers,
Ben.
