Date: Wed, 12 Dec 2001 10:14:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Dixon <andrew.dixon@seranoa.com>,
	ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: r3 and bd_t
Message-ID: <20011212171450.GB27587@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C164F4B.E9A4FCA2@seranoa.com> <20011211183430.GQ22045@cpe-24-221-152-185.az.sprintbbd.net> <20011212171457.GA20492@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212171457.GA20492@shamus.smoothsmoothie.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 11:14:57AM -0600, jtm@smoothsmoothie.com wrote:
> On Tue, Dec 11, 2001 at 11:34:30AM -0700, Tom Rini wrote:
> >
>
> > arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
> > iirc, which will pass it along to platform_init(), which copies it for
> > safe keeping.
>
> I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.

Er, yes.  Sorry, i thought the question was about 8xx not 8260.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
