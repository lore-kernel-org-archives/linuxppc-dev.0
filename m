Message-ID: <37FF5CCD.41B88659@mvista.com>
Date: Sat, 09 Oct 1999 10:18:37 -0500
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: Claude Robitaille <crobitaille@videotron.ca>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Strange behavior on FADS with ICTRL==0
References: <Pine.LNX.4.10.9910091003020.6027-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Claude and Dan:

Thanks for the pointers. I do have an old chip and the erratta does describe this
problem. Shame on me for not having looked at the erratta!
-Jim Lewis

Claude Robitaille wrote:

> Check the version of the chip and change it to a B2 version if it is
> not it. You should be able to get a sample.
>
> Claude
>
> > Jim Lewis wrote:
> >
> >
> > > ........ If the ISCT_SER field of the
> > > ICTRL register is set to 0 (which is the value on reset), the system is
> > > very unstable.
> >
> > You have to be very careful with the configuration of 8xx control and
> > debug registers.  Depending upon the silicon revision, there are certain
> > errata that require explicit settings of these registers.  This is certainly
> > one of them.....some die require serialization to be set, others require you
> > never set it, others require subsequent software work around depending
> > upon the setting.
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
