Date: Thu, 8 Jan 2004 22:57:32 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Tom Rini <trini@kernel.crashing.org>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040108215732.GA23598@iliana>
References: <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan> <20040107112726.GA26193@iliana> <20040107122828.GJ14918@plato.local.lan> <20040107144744.GA29449@iliana> <20040108072733.GM14918@plato.local.lan> <20040108155331.GB18481@stop.crashing.org> <20040108174740.GA19931@iliana> <1073598787.783.160.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073598787.783.160.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 09, 2004 at 08:53:07AM +1100, Benjamin Herrenschmidt wrote:
>
> >
> > Anyway, on pegasos 2, i have the problem that CONFIG_RTC works fine, and
> > the clock is set, but only _later_. This has as result that the clock is
> > wrong when it is the time for filesystem checks, and thus filesystems
> > are checked each time.
>
> Your arch code should set an initial UTC time in the kernel
> that is correct, which is why you really want to properly
> implement working ppc_md.{get,set_rtc_time}, that will get you
> this functionality along with working GENERIC_RTC

Yep, that is what i thought to.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
