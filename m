Date: Wed, 14 Jan 2004 15:10:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: valvoline <valvoline@vrlteam.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: temp.c and cputable.c issues
Message-ID: <20040114221018.GB983@stop.crashing.org>
References: <20040114193910.GN2658@adapter.n0skillz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040114193910.GN2658@adapter.n0skillz.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 14, 2004 at 08:39:10PM +0100, valvoline wrote:

> i've enabled TAU and CPUFREQ, and compiled everything...all seems to go well,
> but looking into a dmesg from kernel i'm receiving this message:
>
> ...
> Thermal assist unit not available
> ...
>
> looking into /usr/src/linux/arch/ppc/kernel/cputable.c i've noticed that all
> 7455 based machine, have the CPU_FTR_TAU feature disabled, so i've patched the
> file as in the included patch...now all seems to works fine!.

There are errata documents from Motorola that tell you not to use the
TAU on any 745x CPU.  The omission of this flag is intentional.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
