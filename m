To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
References: <87u1slf5wf.fsf@theorie.physik.uni-muenchen.de>
	<20020213211243.28959@smtp.wanadoo.fr>
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 14 Feb 2002 06:42:47 +0900
In-Reply-To: <20020213211243.28959@smtp.wanadoo.fr>
Message-ID: <87ofitf488.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I shut down the device when the interface is down for more than
> about 10 seconds.

> Either I fake the ioctl and return no link,

Which makes ifd useless, because it won't be able to detect that a
link is actually present.

> or I power it back up each time, preventing basically the chip to
> ever be power managed.

Which consumes unnecassary power, reducing battery life.  I see the
point.  Would it make sense to make the time between the link going
down and the device powering off configurable, either as a module
parameter or as a kernel config option?  Then one could choose to have
either sensible power management or automatic link detection, if it's
not possible to get both.

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
