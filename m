From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>,
	<linuxppc-dev@lists.linuxppc.org>, <netdev@oss.sgi.com>
Subject: Re: airport reset on iBook2
Date: Mon, 30 Jul 2001 16:32:36 +0200
Message-Id: <20010730143236.16877@smtp.wanadoo.fr>
In-Reply-To: <20010728003701.H1240@obroa-skai.gnumonks.org>
References: <20010728003701.H1240@obroa-skai.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I can confirm that happen from time to time with my Sony VAIO picturebook
>C1XD and a Lucent WaveLAN/IEEE board.
>
>unloading the whole pcmcia subsystem (incl. yenta_socket) and re-loading
>everything helps.

What is your card's firmware version ? (displayed by the driver during
boot). You may want to go to MacOS, upgrade to Apple's latest airport
software, and back to linux. This will upgrade your card's firmware to
the latest version provided by Apple, which might help.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
