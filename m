Date: Mon, 17 Sep 2001 18:11:56 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: Board names for 4xx
To: Dan Malek <dan@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Message-id: <3BA620CC.3ACD0547@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20010914144403.G3851@zax>
 <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net>
 <20010917122828.J3851@zax>
 <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net>
 <3BA61D1A.3A79E5B9@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Tom Rini wrote:
>
> > I do wish someone else would speak up tho.  Does anyone out there have an
> > opinion?
>
> If the information from /proc is just used for pretty print out of
> information, I really don't care.  If there are applications that read
> this for some internal configuration and flexibility, we better have a
> standard format.
>
>         -- Dan

Debian uses /proc/cpuinfo to find out what utility to use for the RTC
(clock,hwclock). This could be fixed if the code from clock was integrated in
hwclock. hwclock tries every method it knows until one works.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
