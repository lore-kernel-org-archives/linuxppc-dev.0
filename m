Date: Sun, 17 Feb 2002 16:19:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com,
	"Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: question on best way to install other ide drives?
Message-ID: <20020217231920.GD15858@opus.bloom.county>
References: <p05101401b895b9cbee49@[10.0.0.42]> <20020217215204.4646@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020217215204.4646@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Feb 17, 2002 at 10:52:04PM +0100, Benjamin Herrenschmidt wrote:
>
> >
> >(A).  IDE does not do a terribly good job of sharing bus bandwidth
> >between two active devices, so the ideal case for performance is one
> >IDE bus per device.
> >
> >That said, you'll never be impacted if your workload never attempts
> >to exercise both the slave and master at the same time.
>
> iirc, the sonet has 2 busses.

Yes, but unless you stress the master and slave at the same time, you'll
never notice.  I bash hda and hdd on my G4 all the time and it never
seems to be 'slow'.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
