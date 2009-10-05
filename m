Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 64AFDB7B7F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 00:47:25 +1100 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1252915227.8375.118.camel@pasglop>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop> <1252915227.8375.118.camel@pasglop>
Content-Type: text/plain
Date: Mon, 05 Oct 2009 09:25:55 -0400
Message-Id: <1254749155.13160.6.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-14 at 18:00 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-09-14 at 06:25 +1000, Benjamin Herrenschmidt wrote:
> > > > .../...
> > > > 
> > > > > Something is totally messed up here.
> > > > 
> > > > Could it be that we don't handle R_PPC64_ADDR16_* relocs in
> > > > arch/powerpc/kernel/modules/module_64.c ?
> > > > 
> > > > Sachin, do you see a bunch of "Unknown ADD relocation" in your dmesg ?
> > > 
> > > Ben,
> > > 
> > > The thing is, this is kernel proper. This code is in entry_64.S not in
> > > the module code.
> > 
> > Argh... indeed.
> > 
> > Sachin, can you give me more details on how you built that kernel ? (or
> > give them again in case I missed them the first time around :-), ie,
> > what toolchain, options, etc... or even better, give me remote access to
> > the build host ?
> 
> Ok, got access and had a quick look... seems to be a toolchain problem
> to me. I'll investigate more tomorrow.

Hi Ben,

Any more word on this issue?

-- Steve
