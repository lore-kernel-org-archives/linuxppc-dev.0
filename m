Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option
	break the powerpc kernel on your machine ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040108174740.GA19931@iliana>
References: <20031222162601.GA9021@iliana>
	 <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana>
	 <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan>
	 <20040107112726.GA26193@iliana> <20040107122828.GJ14918@plato.local.lan>
	 <20040107144744.GA29449@iliana> <20040108072733.GM14918@plato.local.lan>
	 <20040108155331.GB18481@stop.crashing.org>  <20040108174740.GA19931@iliana>
Content-Type: text/plain
Message-Id: <1073598787.783.160.camel@gaston>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 08:53:07 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Anyway, on pegasos 2, i have the problem that CONFIG_RTC works fine, and
> the clock is set, but only _later_. This has as result that the clock is
> wrong when it is the time for filesystem checks, and thus filesystems
> are checked each time.

Your arch code should set an initial UTC time in the kernel
that is correct, which is why you really want to properly
implement working ppc_md.{get,set_rtc_time}, that will get you
this functionality along with working GENERIC_RTC

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
