Date: Wed, 1 Oct 2003 14:32:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20031001213239.GA17768@ip68-0-152-218.tc.ph.cox.net>
References: <3F79A106.8010608@embeddededge.com> <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com> <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net> <1065019736.9737.526.camel@hermes> <005801c38861$e7a596a0$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005801c38861$e7a596a0$020120b0@jockeXP>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 01, 2003 at 11:20:50PM +0200, Joakim Tjernlund wrote:
> > On Wed, 2003-10-01 at 08:32, Tom Rini wrote:
> > > On Wed, Oct 01, 2003 at 09:26:29AM -0500, Kumar Gala wrote:
> > >
> > > > Did I miss something or did is someone moving this patch from 8xx to
> > > > 8260?  It looks like Tom's commit of Joakim's work was for 8xx.
> > >
> > > No one has moved this to 8260 as no one with access to hw (not me,
> > > easily) has time to do it.  If you can, I'll apply it.
>
> Commited where? I can't see it in http://ppc.bitkeeper.com:8080/linuxppc_2_4_devel

It's in the linuxppc-2.4 tree.  I'll try and get it to Marcelo in time
for 2.4.21-pre7.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
