Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2D1192BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jan 2005 03:17:42 +1100 (EST)
Date: Mon, 3 Jan 2005 17:17:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio?= Cargnini <vitorio@digitel.com.br>
In-Reply-To: <1104758458.14925.5.camel@vitorio>
Message-ID: <Pine.GSO.4.61.0501031717080.27452@waterleaf.sonytel.be>
References: <1104758458.14925.5.camel@vitorio>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-559023410-1914471406-1104769056=:27452"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Making a serial multiplexer (new driver)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1914471406-1104769056=:27452
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 3 Jan 2005, [ISO-8859-1] Luís Vitório Cargnini wrote:
> Hi i need to write a driver that must multiplex an serial channel my
> driver will have  3 interfaces and i must communicate with another
> interface  (midleware) like /dev/ttyS2 for example, how could i write a
> driver that will communicate with my existing uart ???
> 
> i have a component that could be multiplexed in 3 logical channels throw
> my single physical channel that are accessed with a normal serial
> interface using uart, how could this be possible ?
> this is necessary to be transparent to software user level.

Do it in userspace using fifos?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-1914471406-1104769056=:27452--
