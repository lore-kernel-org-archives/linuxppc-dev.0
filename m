Message-ID: <39D0DDE4.5D11477F@mvista.com>
Date: Tue, 26 Sep 2000 10:33:24 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: David Edelsohn <dje@watson.ibm.com>,
        "David N. Welton" <davidw@linuxcare.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC405 - supported?
References: <Pine.LNX.3.96.1000926092818.13281S-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David A. Gatwood" wrote:
>
> On Tue, 26 Sep 2000, David Edelsohn wrote:
>
> >       Are you referring to the IBM PowerPC 405 embedded processor?  IBM
> > part numbers are PPC405 (not Motorola MPC505).  I am pretty sure that the
> > 4xx numbers are IBM parts.
> >
> >       I have seen patches from MontaVista for 405 support in the
> > toolchain, so they may be working with PPC405 chips.
>
> Yeah.  We demoed an IBM-built 405GP development box at the LWE a few weeks
> ago, running some Hard Hat Linux-based setup acting as a web server, IIRC.
> I'm not sure to what extent the various embedded controllers and stuff are
> supported, but the core functionality works, anyway.  :-)
>
> David
> a.k.a. dgatwood@mvista.com

Yes, there is extensive support for the IBM PowerPC 405 embedded processor
family (405 based processors from IBM include the 405GP, 405CR, STB03xxx, NPe405)
available from MontaVista.  The development web site is currently slightly stale:

  http://dev.mvista.com/projects/405gp_status/main.html

There is newer source on the ftp site than the web page describes (September 9)
and there should be a newer version of source and an updated web page within
the next few weeks.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
