Message-ID: <20040531015917.47683.qmail@web15207.mail.bjs.yahoo.com>
Date: Mon, 31 May 2004 09:59:17 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: 8xx-2.6 | Prolog
To: Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40B6DEC8.2070605@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou <panto@intracom.gr> wrote:

> > Dan Malek wrote:

> > The interrupt stuff in patch 1 was wrong when it was done in 2.4 and
> > I'm disappointed to see it again in 2.6. Unfortunately, I don't have
> > time to fix it now, but it will get done properly when I implement
> > the similar thing for the 8560.
>
> Well, I had to do something. request_8xxirq & friends are unusable.

I tested External Interrupt of 823e with
request_8xxirq on IRQ1-IRQ7 in 2.4.18(MVL3.0-rpxlite
BSP) last night.It did work.But I failed many times to
make PCMCIA IP_B7 interrupt work,which should be
treated as External Interrupt--registered fine but
without any response to IP_B7 change.

I wonder whether "interrupt stuff" as you metioned had

any relation with my case.

Sorry for disturbing you all! :-)

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
