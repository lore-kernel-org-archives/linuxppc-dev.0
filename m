Date: Wed, 12 Dec 2001 13:56:00 -0700
From: Matt Porter <mporter@mvista.com>
To: Jim Thompson <jim@smallworks.com>
Cc: jtm@smoothsmoothie.com, trini@kernel.crashing.org,
	andrew.dixon@seranoa.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: r3 and bd_t
Message-ID: <20011212135600.C21676@cx258813-a.chnd1.az.home.com>
References: <200112122257.QAA07497@hosaka.smallworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112122257.QAA07497@hosaka.smallworks.com>; from jim@smallworks.com on Wed, Dec 12, 2001 at 04:57:11PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 04:57:11PM -0600, Jim Thompson wrote:
>
> >> arch/ppc/kernel/head_8xx.S saves this and passes it onto early_init()
> >> iirc, which will pass it along to platform_init(), which copies it for
> >> safe keeping.
> >
> > I think the 8260 uses arch/ppc/kernel/head.S instead of head_8xx.S.
>
> And the 8245?

head.S handles classic PPC cores (6xx/7xx/74xx/82xx).
head_4xx.S and head_8xx.S are obvious then.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
