Message-ID: <DF2B720CF774D21189EE00805FA7FA22051783B9@nmrusdunsx3.nielsenmedia.com>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: PowerMac vs. Intel for PowerPC Development Host
Date: Thu, 20 Feb 2003 10:41:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: Wells, Charles
Sent: Thursday, February 20, 2003 9:48 AM
To: 'Chris Wedgwood'
Subject: RE: PowerMac vs. Intel for PowerPC Development Host

While I don't want to get into the Mac vs. Intel debate, I have an
observations about Paul's numbers.

Building kernels requires a lot of disk accesses.  The Toshiba/Hitachi/IBM
style hard disks that are used in most modern laptops (Mac or Intel) are
notoriously slow compared to full-sized desktop hard drives (particularly
the high performance SCSI drives).  It wouldn't be meaningful to compare two
systems without describing the access time performance of the hard disks.

While I don't have the numbers in front of me, I believe the the fastest
machine I have access to for building kernels is my trusty old 450 MHz.
desktop G3 at home.  It has 3 very fast IBM SCSI drives.  In my book, how
fast a kernel compiles is as much a matter of how much you're willing to
spend on hard drives as it is CPU architectural considerations.  Leave the
"CPU clock speed comparisons" to the marketing guys.

-----Original Message-----
From: Chris Wedgwood [mailto:cw@f00f.org]
Sent: Thursday, February 20, 2003 12:46 AM
To: Paul Mackerras; Eugene Surovegin
Cc: brian.auld@adic.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host

On Thu, Feb 20, 2003 at 12:22:52PM +1100, Paul Mackerras wrote:

> As an actual data point: my measurements show that a dual 1GHz G4
> powermac is more than twice as fast at compiling PPC kernels as a
> 1.7GHz P4 (single cpu).

Wow... that's *much* better that I would have guessed.  Is the
compiler the same for each?

> You can't fairly compare compiling a PPC kernel on a PPC box with
> compiling an x86 kernel on an x86 box.  GCC does more work compiling
> for PPC than for x86.

I wasn't trying to compare fairly, mostly get the lowest possible
compile time.


On Wed, Feb 19, 2003 at 09:10:48PM -0800, Eugene Surovegin wrote:

> I tried to compile the _same_ PPC kernel for one of boards (440GP
> based).

> Cross compiling on PIII 755Mhz running SuSE        - 16 min
> Cross compiling on G4 PowerBook 1Ghz running YDL   - 6 min

I don't have a PPC host to reasonably compare with, but a 440GP kernel
(linuxppc_2_4_devel) for me builds in 3 minutes 29s (with gcc-2.95).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
