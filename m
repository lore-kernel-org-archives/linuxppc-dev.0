Date: Wed, 19 Feb 2003 21:45:34 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Mackerras <paulus@samba.org>,
	Eugene Surovegin <ebs@ebshome.net>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
Message-ID: <20030220054534.GA24107@f00f.org>
References: <20030220010112.GB22880@f00f.org> <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com> <20030220010112.GB22880@f00f.org> <5.1.0.14.2.20030219210505.037b67e8@mail.ebshome.net> <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com> <20030220010112.GB22880@f00f.org> <15956.11756.925757.532452@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030219210505.037b67e8@mail.ebshome.net> <15956.11756.925757.532452@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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



   --cw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
