Message-Id: <5.1.0.14.2.20030219210505.037b67e8@mail.ebshome.net>
Date: Wed, 19 Feb 2003 21:10:48 -0800
To: Chris Wedgwood <cw@f00f.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <15956.11756.925757.532452@argo.ozlabs.ibm.com>
References: <20030220010112.GB22880@f00f.org>
 <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
 <20030220010112.GB22880@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:22 PM 2/19/2003, Paul Mackerras wrote:

>Chris Wedgwood writes:
> >
> > On Wed, Feb 19, 2003 at 01:52:58PM -0800, brian.auld@adic.com wrote:
> >
> > > In the Intel vs. Mac debate for a linux development host for
> > > embedded ppc development, if money was not an issue, would I get
> > > more PowerMac recommendations??
> >
> > Despire what Apple and a few other people claim, Intel solutions are
> > faster in terms of compile times, and if money was no barrier, then
> > Intel solutions are potentially *much* faster.
>
>As an actual data point: my measurements show that a dual 1GHz G4
>powermac is more than twice as fast at compiling PPC kernels as a
>1.7GHz P4 (single cpu).
>
>You can't fairly compare compiling a PPC kernel on a PPC box with
>compiling an x86 kernel on an x86 box.  GCC does more work compiling
>for PPC than for x86.

My 5 cents :)

I tried to compile the _same_ PPC kernel for one of boards (440GP based).

Cross compiling on PIII 755Mhz running SuSE        - 16 min
Cross compiling on G4 PowerBook 1Ghz running YDL   - 6 min

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
