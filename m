Message-ID: <3A7F9312.7E539127@pop.agri.ch>
Date: Tue, 06 Feb 2001 07:00:56 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Correct CPU/bus frequency on a wallstreet.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

maybe be a bit OT but I hope to get an answer here.

Since a few months I'm really happy! I got an increase of the CPU and
the bus clock for free. I own a Wallstreet I from summer 98 with G3
250MHz CPU and 83 MHz bus clock. As said, the Apple profiler and the OF
tells me since a few months I have a 300MHz CPU and a 100MHz bus clock,
great, but I can't believe! I can't remember when it changed.

The different Cache utilities and the Metronome app all tell me the
expected CPU and bus clock.

Yesterday I wanted to see what's going on with my L2 cache on the linux
side. So I saw that I have there 300MHz too, a look into the code showed
me that these values are taken from the OF, right? But the so called
Bogo value 'seems' to be correct, twice the cpu clock.
Also, who sets the L2 cache? Is it BootX and or G3/G4 Cache porfiler? On
the Mac side I run a value of 0xB5080000, on the linux side it is: L2CR
overriden (0xb5000000), backside cache is enabled

So what I'm wondering about how and who changed my cpu/bus values in OF?
I didn't play wit OF, and I'm quite sure that I reset the whole machine
quite a lot during the past months. And how becomes that e.g. a
Powerlogix Cache profiler can tell me the expected values. And even the
temp of the cpu (I read that there are some attempts regarding temp in
bk_2_5, right?)

Is it the right way to rely on OF for these values?
This topic is not life critical, sure.

Any insight???

Thanks for response


Cheers

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
