Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8663E67A2F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 03:03:38 +1100 (EST)
Date: Mon, 14 Mar 2005 17:02:47 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20050314154504.GA7267@Redstar.dorchain.net>
Message-ID: <Pine.LNX.4.62.0503141702040.20641@numbat.sonytel.be>
References: <20050314154504.GA7267@Redstar.dorchain.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Heartbeat apps thoughts
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 Mar 2005, Joerg Dorchain wrote:
> I am pondering a heartbeat functionality implementation. Currently, I
> have a patch that adds a few line to the timer interrupt to switch the
> led on and off when appropriate.
> 
> On the list, there were opinions that switching the led on and off would
> be best done via userspace. While I in principle agree, I have some
> considerations:

And then we (kernel hackers) cannot use it anymore to see whether interrupts
are still working...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
