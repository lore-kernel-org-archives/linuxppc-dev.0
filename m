Date: Wed, 7 Jan 2004 22:27:33 -0900
From: Ethan Benson <erbenson@alaska.net>
To: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040108072733.GM14918@plato.local.lan>
References: <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan> <20040107112726.GA26193@iliana> <20040107122828.GJ14918@plato.local.lan> <20040107144744.GA29449@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040107144744.GA29449@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 03:47:44PM +0100, Sven Luther wrote:
>
> The worse that can happen is the GENERIC_RTC driver not being
> initialized because linux believes the RTC driver should be ok.

which breaks hwclock, not acceptable.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
