Message-ID: <37E03044.9653F5D2@ctam.com.au>
Date: Thu, 16 Sep 1999 09:48:21 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.3.10 configuration questions.
References: <37DEF583.3DC2F0D4@ctam.com.au> <37DFF342.94EE3B8@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> > .....This worries me a bit,
> > especially having 8xx and 6xx cpus both defined.  Is this intentional ?
>
> Well, you can either worry or fix it and get on with life.  Keep in
> mind that the 8xx is really a minimal change to the Linux/PPC baseline.
> If something doesn't work on the 8xx, and it is not specific to
> the 8xx (like the file system stuff), chances are it doesn't work
> for any PPC release.  Build it for a PMAC or something (you do have
> some other PPC besides the 8xx, right?) and compare the results.

No, unfortunately I do not have access to a powermac.  My x86 laptop is just
about getting to the end of it's warranty and I am looking at upgrading in the
next month or so.  Since I have no desire to run DOS/Windows programs AND the
powerpc G3/G4 machines kick ass, I will probably upgrade to a PowerBook :)


> Remember, the 2.3.x CVS is a serious development tree, changing
> every minute, and can go for many releases without running
> properly in many aspects.  When you play in this sandbox you have
> to expect things not to work correctly, and contribute to the
> updates.

I do expect things not to work.  I do not know the kernel internals very well
and I am not confident in changing things willy nilly.  Reporting things to
the mailing list seems reasonable to me to see if others have seen similar
things and have found solutions.  I don't mind getting my hands dirty and
trying things but I would rather wait for some direction from others first so
I don't head down the wrong track and possibly stuff up something that didn't
really have a problem.

In a previous email you mentioned that the embedded-2.2.5 release is still the
most stable, but you recommended to me that the 2.3.10 kernels are the place
to start for new ports.  I think I will do the port for the 2.2.5 first and
then migrate it to the 2.3.x stuff later.  Does this sound reasonable ?

Brendan Simon.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
