Date: Fri, 15 Aug 2003 12:52:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Frederic Maccotta <frederic.maccotta@fr.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.4.20: kgdb problem
Message-ID: <20030815195217.GX807@ip68-0-152-218.tc.ph.cox.net>
References: <OF80DE9996.69682759-ONC1256D82.0028EF6B@megacenter.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF80DE9996.69682759-ONC1256D82.0028EF6B@megacenter.de.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 14, 2003 at 09:34:30AM +0200, Frederic Maccotta wrote:

> I experienced many problems trying to use ans set kgdb/gdb with a ppc
> kernel 2.4.20. (Note: No problem with kgdb & kernel version 2.4.17)
>
> I used gcc 3.2.1 to compile the kernel and gdb 5.2.1 as remote debugger.
>
> I enabled kgdb feature and added "-g -ggdb -O" compile options running
> make nenuconfig

You don't need to add -O.

>  Problem: I first tried to compile kernel with "-fno-omit-frame-pointer"
> but the compiled kernel was hanging somewhere in network init. I did not
> have this problem with 2.4.17 version.
>
>  Question-1: Is the frames pointer in a ppc kernel really mandatory to
> allow debugging (as for i386 platform) ?

You do not need to change this setting to get KGDB to work on PPC.

> Problem: I did not succeed to disable optimization (-O0). In this case
> the linker complains about unreferrenced inline functions.
>
> Question-2: Does it exist a way to compile a ppc kernel without
> optimization ?

No.  This is probably FAQ'ed somewhere, and google can explain all of
the reasons why the linux kernel MUST be compiled with some level of
optimization.

> Once the kernel is compiled with kgdb, I am able to establish a
> connection with gdb, but the behavior of debugging operations (step one
> instruction, continue up to <addr> ...) is really erratic.

What board are you trying to use KGDB with?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
