Date: Wed, 16 Jun 2004 09:52:58 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Mark Chambers <markc@mail.com>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hardware interrupts routines
In-Reply-To: <009501c453ad$b6be50f0$0301a8c0@chuck2>
Message-ID: <Pine.LNX.4.44.0406160950550.11299-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 16 Jun 2004, Mark Chambers wrote:
> But isn't he going to have to write a device driver in order to call
> request_irq()?

He is going to have to write a loadable module, which may or may not
have the normal driver entry points. If he is handling a PCI device,
he definately should be writing a device driver.

-Bret

> You can't just call request_irq() from an application, can
> you?

That is correct.

> If not, is there any way to grab an interrupt other than writing a
> device driver?

Any kernel code (i.e. loadable module) can call the routine.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
