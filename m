Date: Tue, 10 Jul 2001 19:47:14 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel-2.4.7.pre5
Message-ID: <20010710194714.A30905@suse.de>
References: <20010710210004.Postino-030256@smtp01.highway.ne.jp> <20010710142113.B21458@suse.de> <20010710104403.G692@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010710104403.G692@opus.bloom.county>; from trini@kernel.crashing.org on Tue, Jul 10, 2001 at 10:44:03AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 10, Tom Rini wrote:

> On Tue, Jul 10, 2001 at 02:21:13PM +0200, Olaf Hering wrote:
> > /mirror/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_ksoftirqd-7_ppc-2
                                                     ^^^
> > But Paul was/is not very happy about that softirq thing...
>
> iirc, Paul doesn't think the first chunk is still needed. The 2nd chunk is
> needed for pre4/pre5, but the last chunk looks wierd.  It removes
> __cpu_raise_softirq on PPC, which in pre5 all arches still have (x86 is
> slightly different then the rest).

note the pre version string ;)
Just tweak it a bit.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
