Message-ID: <39107960.9A033139@adtran.com>
Date: Wed, 03 May 2000 14:09:20 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need CPM clock >= 100 Mhz for fast ethernet operation
References: <m12n2oz-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:
>
> > From: Dan Malek <dan@netx4.com>
> > Organization: Embedded Edge, LLC
>
> > diekema_jon wrote:
> >
> > >         - What clock multiplier are you using for the CPM?
>
> > I don't remember.  I think it was clock mode 0010_011, which would
> > be 133 MHz CPM and 166 MHz core.  This is all pretty simple.  Just
> > pick your own clock speed and set the board descriptor in embed_config.c
> > to match it.
>
> In order for fast Ethernet to work reliably, the CPM clock needs to be
> >= 100 Mhz.
>
> If the CPM clock is 66 Mhz, then about 1 of 5-20 Tx packets will get
> dropped.  It also appears that Rx has precedence over Tx.  We are
> guessing that the CPM runs out of cycles at 66 Mhz while trying to
> support fast ethernet.

 ???

 I didn't think the SCC could support fast ethernet at any clock speed,
thats why moto put the FEC (Fast Ethernet Controller) in the FEC, which
supports fast ethernet at rates > 25Mhz (full duplex @ 40Mhz).

ron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
