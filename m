From: linas@austin.ibm.com
Date: Thu, 29 Apr 2004 11:31:17 -0500
To: Tameen Khan <tameen@cisco.com>
Cc: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
	"'linuxppc-dev list'" <linuxppc-dev@lists.linuxppc.org>,
	hbabu@us.ibm.com
Subject: Re: stack frame for interrupts/exceptions in PPC
Message-ID: <20040429113117.V58706@forte.austin.ibm.com>
References: <1083118036.20092.30.camel@gaston> <008d01c42d48$0baae1a0$273147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008d01c42d48$0baae1a0$273147ab@amer.cisco.com>; from tameen@cisco.com on Wed, Apr 28, 2004 at 10:41:32AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 28, 2004 at 10:41:32AM -0700, Tameen Khan wrote:
>
> > > > I am tryting to implement kernel backtracing for PPC.
> >
> > What do you mean ? There is already working backtrace code in
> > the kernel, both in the Oops code and in xmon.

and KDB too...

> Did not know that. Am new to linux and ppc.
> I'm porting lkcdutils for PPC. It picks up a kernal core dump and among
> other things has to generate backtraces from it.

You may want to talk to Haren Myneni <hbabu@us.ibm.com>
who I beleive is also working LKCD on PPC64

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
