Date: Mon, 1 Apr 2002 08:20:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Message-ID: <20020401152036.GA6360@opus.bloom.county>
References: <3CA4EDA9.5C885292@mvista.com> <0203300045.AA13159@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203300045.AA13159@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 29, 2002 at 04:45:43PM -0800, Michael Sokolov wrote:
>
> Mark A. Greer <mgreer@mvista.com> wrote:
>
> > Okay, the bi_recs need to be copied.  Something for you to do over the weekend ;)
>
> I don't know how to do that in a way acceptable to you. I only know how to do
> things my way, which I've done in my patch which you've pocket-vetoed.
>

IIRC, your original patch did the parsing in parse_bootinfo() or so in
arch/ppc/kernel/setup.c which means each new driver bi_rec needs to
modify arch/ppc/kernel/setup.c, which isn't nice.  What we need is
something like how we save Motorola residual data or bd_info stuffs
(memcpy in platform_init).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
