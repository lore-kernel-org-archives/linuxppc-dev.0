Date: Sat, 6 Jan 2001 10:45:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Holzt <kju@fqdn.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bugs in 2.4.0-ac2 in ppc
Message-ID: <20010106104527.C1400@opus.bloom.county>
References: <20010105210627.D1095@fqdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010105210627.D1095@fqdn.org>; from kju@fqdn.org on Fri, Jan 05, 2001 at 09:06:28PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 05, 2001 at 09:06:28PM +0100, Michael Holzt wrote:

>  - function set_pgdir disappeared somewhere late in the 2.4.0test
>    series. I had to copy the source from an older kernel to get the
>    kernel to compile.

The proper fix is to remove the if (..) set_pgdir.

>  - And third the worst problem: Since one of the latest test series
>    kernels i'm unable to use modules:
>
>    For all modules i try i get unresolved symbols - for trivial functions:
>
>    bash-2.03# insmod ./loop.o
>    ./loop.o: unresolved symbol memset
>    ./loop.o: unresolved symbol int_control_R58a1efa3
>    ./loop.o: unresolved symbol __copy_tofrom_user_Re410a3dd
>    ./loop.o: unresolved symbol memcpy
>    ./loop.o: unresolved symbol strncpy_R328a05f1

Can you please email me privately your .config file?  I will look into this.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
