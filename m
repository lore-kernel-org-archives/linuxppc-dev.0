Date: Wed, 12 Dec 2001 07:08:06 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>,
	ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: r3 and bd_t
Message-ID: <20011212070806.A21676@cx258813-a.chnd1.az.home.com>
References: <3C164F4B.E9A4FCA2@seranoa.com> <20011211183430.GQ22045@cpe-24-221-152-185.az.sprintbbd.net> <20011212171457.GA20492@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212171457.GA20492@shamus.smoothsmoothie.com>; from jtm@smoothsmoothie.com on Wed, Dec 12, 2001 at 11:14:57AM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 11:14:57AM -0600, jtm@smoothsmoothie.com wrote:
>
> On Tue, Dec 11, 2001 at 11:34:30AM -0700, Tom Rini wrote:
> >
>
> > arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
> > iirc, which will pass it along to platform_init(), which copies it for
> > safe keeping.
>
> I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.

It has to, it's a 603 core.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
