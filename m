Date: Tue, 31 Jul 2001 03:18:18 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <netdev@oss.sgi.com>
Subject: Re: airport reset on iBook2
Message-ID: <20010731031818.K1486@obroa-skai.gnumonks.org>
References: <20010728003701.H1240@obroa-skai.gnumonks.org> <20010730143236.16877@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010730143236.16877@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Mon, Jul 30, 2001 at 04:32:36PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 30, 2001 at 04:32:36PM +0200, Benjamin Herrenschmidt wrote:
> >I can confirm that happen from time to time with my Sony VAIO picturebook
> >C1XD and a Lucent WaveLAN/IEEE board.
> >
> >unloading the whole pcmcia subsystem (incl. yenta_socket) and re-loading
> >everything helps.
>
> What is your card's firmware version ? (displayed by the driver during
> boot). You may want to go to MacOS, upgrade to Apple's latest airport
> software, and back to linux. This will upgrade your card's firmware to
> the latest version provided by Apple, which might help.

erm, as I said, I have a Lucent card and a x86 box.  There is no MacOS
and I don't want to write an AirPort firmware to the Lucent card.

> Ben.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
