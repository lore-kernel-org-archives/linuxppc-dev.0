From: "Tameen Khan" <tameen@cisco.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: "'linuxppc-dev list'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: stack frame for interrupts/exceptions in PPC
Date: Wed, 28 Apr 2004 10:41:32 -0700
Message-ID: <008d01c42d48$0baae1a0$273147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1083118036.20092.30.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I am tryting to implement kernel backtracing for PPC.
>
> What do you mean ? There is already working backtrace code in
> the kernel, both in the Oops code and in xmon.

Did not know that. Am new to linux and ppc.
I'm porting lkcdutils for PPC. It picks up a kernal core dump and among
other things has to generate backtraces from it.

Thanks for the info
Tameen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
