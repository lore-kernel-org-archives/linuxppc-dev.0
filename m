Date: Fri, 15 Nov 2002 09:17:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem in booting PPC with kernel 2.5.44
Message-ID: <20021115161724.GA13063@opus.bloom.county>
References: <20021114151136.GB14431@opus.bloom.county> <Pine.OSF.4.10.10211151612210.11070-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.OSF.4.10.10211151612210.11070-100000@moon.cdotd.ernet.in>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 15, 2002 at 04:24:36PM +0500, Atm account wrote:
>
> On Thu, 14 Nov 2002, Tom Rini wrote:
> > >     Now the problem is ... the kernel has been linked at 3GB and a call in
> > > kernel/head.S which says ---
> > How did you change things to have it link at 3GB?
> 	What else is it linked at?? Is it not what KERNELBASE is assigned
> to?? AFAIK kernel links at 0xc0000000 and the bootloader at
> 8Mb (PPC based boards).

Did you change the file itself, or did you make use of
CONFIG_ADVANCED_OPTIONS, is what I'm asking.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
