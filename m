To: "Pergola, Michael" <MichaelPergola@Danfoss.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Support (E-mail)" <techsupport@embeddedplanet.com>
Subject: Re: Serial Port problem with 823e on Embedded Planet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Jun 2001 13:50:17 EDT."
             <E1836A7F3557D311A14000805F9F36FCD4E383@usdfo011.usac.danfoss.net>
Date: Wed, 27 Jun 2001 20:09:55 +0200
Message-Id: <20010627181000.47164100B1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Michael,

in message <E1836A7F3557D311A14000805F9F36FCD4E383@usdfo011.usac.danfoss.net> you wrote:
>
> I have an Embedded Planet with a LITE_DW Motorola 823 PPC using a HIOX
> interface board. I am trying to debug a program sending out data from
> ttyS1 and reading it back in on ttyS2. The latest patch has been applied

I guess you are using the SMC ports for the ttyS* ?

> I want to be able to send any char over the serial link, so I've resorted to
> using "raw" mode. The problem is that if an overrun occurs on the receive
> side, there is nothing I can sense to indicate this situation. Has anyone
> run into this problem and/or is there a solution to my dilemma?

In raw mode you're kind of lost - the SMC's don't have any  handshake
signals.

You could switch to use SCC's instead. We have a modified driver that
supports full HW handshake on all SCC's (and you  can  configure  the
number and size of I/O buffers to optimize for throughput).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A direct quote from the Boss: "We passed over a lot of good people to
get the ones we hired."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
