From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15571.5505.916224.351719@argo.ozlabs.ibm.com>
Date: Sat, 4 May 2002 08:56:01 +1000 (EST)
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Powerbook
In-Reply-To: <3CD29410.2DB93FF5@folkwang-hochschule.de>
References: <EADB10BAC266A14A85ECBF8686A73E31937F1C@kolkrabbi.flaga.is>
	<3CD29410.2DB93FF5@folkwang-hochschule.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joern Nettingsmeier writes:

> <asbestos mode="full body protection">
> if you're in for quick compilation, get an intel machine.
> </asbestos>

No, if you're in for quick compilation, compile a kernel for i386
rather than a kernel for ppc, for some reason gcc is quicker at
producing x86 output than ppc output, i.e. the x86 compilation
involves less computation.

About 18 months ago I did a comparison of a (then) recent dual G4
powermac with a (then) recent dual pentium II system.  I timed all
four combinations of ppc or x86 machine and ppc or x86 output.  The
ppc machine was consistently faster than the x86 machine for the same
computation, although the ppc machine producing ppc output was slower
than the x86 machine producing x86 output.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
