Date: Wed, 12 Dec 2001 16:23:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jim Thompson <jim@smallworks.com>
Cc: jtm@smoothsmoothie.com, andrew.dixon@seranoa.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: r3 and bd_t
Message-ID: <20011212232307.GB28967@cpe-24-221-152-185.az.sprintbbd.net>
References: <200112122257.QAA07497@hosaka.smallworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112122257.QAA07497@hosaka.smallworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 04:57:11PM -0600, Jim Thompson wrote:
> >> arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
> >> iirc, which will pass it along to platform_init(), which copies it for
> >> safe keeping.
> >
> > I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.
>
> And the 8245?

arch/ppc/kernel/head.S as well.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
