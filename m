To: Dan Malek <dan@embeddededge.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	"Kerl,     John" <John.Kerl@Avnet.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx, FEC and DP83847 !? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Mar 2002 14:34:03 EST."
             <3C9A35AB.9080701@embeddededge.com>
Date: Thu, 21 Mar 2002 20:57:25 +0100
Message-Id: <20020321195730.04767109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C9A35AB.9080701@embeddededge.com> Dan Malek wrote:
>
> >> The Motorola reference boards use port D for MII, but we
> >> used PCMCIA/port A pins instead.
>
> If someone is doing this, please send me some patches for the
> driver when you get it working.  All of the 857s I have seen
> are still using Port D for the FEC.  I guess I could make the
> changes if someone else can test them.

Just grab our latest source tarball, and look  at  the  configuration
for the ICU862 board.

> > I supposed you're using PORT D for something else!?
>
> The intention is to also be able to use Port D for the ATM UTOPIA
> so you can have 10/100 and ATM on the same part.  This is really
> the purpose of the 857, although I have yet to see anyone use it
> that way :-).

Well, the ICU862 is such a board, based on a MPC862.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Things that try to look like things often do look  more  like  things
than things. Well-known fact.       - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
