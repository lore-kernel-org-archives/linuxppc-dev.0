Message-ID: <38DA6E1D.F4F25255@execpc.com>
Date: Thu, 23 Mar 2000 13:18:53 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Synchronous SCSI at 10MB/s on Lombard? (fwd)
References: <Pine.SOL.3.95.1000323191623.26407B-100000@juliet>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
> I didn't know you could set it at some speed in between - I rather thought
> these were basically two different settings, with 5 or 10 MB/s being the
> nominal transfer rate, and actual transfer rating below that. According

I'm not sure myself.  never tried it. ^_^;

> to dmesg my Orb drive is found and communicated at 10MB/s, thus the 6.6
...
> that you shouldn't mix HDs and CDROMs, scanners etc. on one chain, the
> latter seem to tend to have worse SCSI implementation.

Thats interesting.  I will have to try that some time.  Right now, my chain has
the CDRW after the Syquest, and I never figured in the potential sync problems.
However, I recall one of my friends mentioning that 10M/s should not be possible
because the compact connector on powerbooks is missing those extra 12 or so pins
needed.  Maybe the Orb is reporting 10, but falling back or compensating for the
lack of pins.  Or maybe connectors have changed.  My chain's Syquest has a
Centronix connector, my RW has a 50 pin mini-trapezoid.  Could explain some
things.  Whatever works i guess.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Ask yourself, Why do you seek the developer kernel?  Is it for its glory,
 or for yours?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
