Date: Wed, 1 Oct 2003 15:31:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20031001223156.GC17768@ip68-0-152-218.tc.ph.cox.net>
References: <3F79A106.8010608@embeddededge.com> <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com> <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net> <1065019736.9737.526.camel@hermes> <005801c38861$e7a596a0$020120b0@jockeXP> <20031001213239.GA17768@ip68-0-152-218.tc.ph.cox.net> <006001c38866$3017e560$020120b0@jockeXP> <20031001220048.GB17768@ip68-0-152-218.tc.ph.cox.net> <007a01c38869$c2287200$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <007a01c38869$c2287200$020120b0@jockeXP>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 02, 2003 at 12:17:10AM +0200, Joakim Tjernlund wrote:
> > > > It's in the linuxppc-2.4 tree.  I'll try and get it to Marcelo in time
> > > > for 2.4.21-pre7.
> > >
> > > Ahh, found it in http://ppc.bkbits.net:8080/linuxppc-2.4. I did look in
> > > http://ppc.bitkeeper.com:8080/linuxppc_2_4 but it is not there. Is this tree obsolete?
> >
> > It's not preferred, certainly.
>
> What about linuxppc_2_4_devel? Is that also "non preferred"?

Yes.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
