Date: Tue, 10 Jul 2001 10:44:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel-2.4.7.pre5
Message-ID: <20010710104403.G692@opus.bloom.county>
References: <20010710210004.Postino-030256@smtp01.highway.ne.jp> <20010710142113.B21458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010710142113.B21458@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 10, 2001 at 02:21:13PM +0200, Olaf Hering wrote:
>
> On Tue, Jul 10, Kaoru Fukui wrote:
>
> >
> > Hi!
> >
> > I had this problem in linuxppc_2_4 bk tree's linux-2.4.7.pre5.
> > Is my fix correct ?
>
> The "correct" fix would be somthing like that:
> /mirror/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_ksoftirqd-7_ppc-2
>
> But Paul was/is not very happy about that softirq thing...

iirc, Paul doesn't think the first chunk is still needed. The 2nd chunk is
needed for pre4/pre5, but the last chunk looks wierd.  It removes
__cpu_raise_softirq on PPC, which in pre5 all arches still have (x86 is
slightly different then the rest).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
