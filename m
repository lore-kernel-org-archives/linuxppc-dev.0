From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15956.11756.925757.532452@argo.ozlabs.ibm.com>
Date: Thu, 20 Feb 2003 12:22:52 +1100
To: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
In-Reply-To: <20030220010112.GB22880@f00f.org>
References: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
	<20030220010112.GB22880@f00f.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Chris Wedgwood writes:
>
> On Wed, Feb 19, 2003 at 01:52:58PM -0800, brian.auld@adic.com wrote:
>
> > In the Intel vs. Mac debate for a linux development host for
> > embedded ppc development, if money was not an issue, would I get
> > more PowerMac recommendations??
>
> Despire what Apple and a few other people claim, Intel solutions are
> faster in terms of compile times, and if money was no barrier, then
> Intel solutions are potentially *much* faster.

As an actual data point: my measurements show that a dual 1GHz G4
powermac is more than twice as fast at compiling PPC kernels as a
1.7GHz P4 (single cpu).

You can't fairly compare compiling a PPC kernel on a PPC box with
compiling an x86 kernel on an x86 box.  GCC does more work compiling
for PPC than for x86.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
