Date: Sat, 09 Oct 1999 10:05:57 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Strange behavior on FADS with ICTRL==0
In-reply-to: <37FF406C.BF6C6BEF@jlc.net>
Cc: Jim Lewis <jlewis@mvista.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <Pine.LNX.4.10.9910091003020.6027-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Check the version of the chip and change it to a B2 version if it is
not it. You should be able to get a sample.

Claude


> Jim Lewis wrote:
> 
> 
> > ........ If the ISCT_SER field of the
> > ICTRL register is set to 0 (which is the value on reset), the system is
> > very unstable.
> 
> You have to be very careful with the configuration of 8xx control and
> debug registers.  Depending upon the silicon revision, there are certain
> errata that require explicit settings of these registers.  This is certainly
> one of them.....some die require serialization to be set, others require you
> never set it, others require subsequent software work around depending
> upon the setting.
> 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
