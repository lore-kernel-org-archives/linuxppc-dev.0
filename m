Date: Wed, 17 Dec 2003 17:56:08 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031217165608.GA11653@iliana>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20031217164740.GR11761@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 17, 2003 at 09:47:40AM -0700, Tom Rini wrote:
> 4) Use CONFIG_GEN_RTC and be happy.  What _might_ be happening right now
> is that chrp_get_rtc_time is 'funky' and not quite right for anything
> other than an IBM OpenFirmeware'd CHRP box.  What I would suggest is
> looking at include/asm-generic/rtc.h in 2.6 and moving much of that code
> into 'chrp_get_rtc_time' and 'chrp_set_rtc_time'.

Ok, thanks, i will look into it.

But then, remember, this is for the debian powerpc kernel, and has to be
2.4.x still for now.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
