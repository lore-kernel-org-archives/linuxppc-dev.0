Date: Thu, 2 Oct 2003 12:15:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Kegel <dank@kegel.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20031002191532.GB21029@ip68-0-152-218.tc.ph.cox.net>
References: <3F79A106.8010608@embeddededge.com> <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com> <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net> <1065019736.9737.526.camel@hermes> <005801c38861$e7a596a0$020120b0@jockeXP> <20031001213239.GA17768@ip68-0-152-218.tc.ph.cox.net> <3F7BBFBE.4060701@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F7BBFBE.4060701@kegel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 01, 2003 at 11:03:42PM -0700, Dan Kegel wrote:
> Tom Rini wrote:
> >>Commited where? I can't see it in
> >>http://ppc.bitkeeper.com:8080/linuxppc_2_4_devel
> >
> >
> >It's in the linuxppc-2.4 tree.  I'll try and get it to Marcelo in time
> >for 2.4.21-pre7.
>
> Say, how up to date is Marcelo's tree in general
> with respect to linuxppc_2_4_devel?  Does it have
> the ppc405 support stuff?

Some, and the better things in 2.6 are being backported, slowly.

> We have been using a linuxppc_2_4_devel snapshot from
> a year or so ago on the ppc405, and it'd be nice to be able to
> move to a vanilla kernel someday.

I hear that...

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
