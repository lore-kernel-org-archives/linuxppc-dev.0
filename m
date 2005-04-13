Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 5B41867B42
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 21:12:31 +1000 (EST)
Date: Wed, 13 Apr 2005 13:12:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B21@exnet.3il.fr>
Message-ID: <Pine.LNX.4.62.0504131311550.3625@numbat.sonytel.be>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B21@exnet.3il.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-630845079-1113390744=:3625"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Dynamic changing of Hz value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-630845079-1113390744=:3625
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Apr 2005, [iso-8859-1] Garcia Jérémie wrote:
> I'm working on a project that needs the clock granularity changed from 10ms to 5ms while running.
> So as a kernel newbie, I understand that I have to deal with the HZ value. I read a lot of things on it through many forums and mailing lists but they always talk about it in a static way (how to fix a value different from 100) as with the Robert love's patch. What I would like to do is to code a routine that allows to modify the HZ value dynamically but the more I read about it and the more I begin to think that it is not possible.
> Could someone tell me if, first of all, it is possible? If yes, what would be the process?
> 
> Note: I'm using a linux montavista pro 3.1 ( kernel 2.4.20 ) with a powerPC 405EP

Googling for `dynamic HZ' gives http://kerneltrap.org/node/4393
It's for 2.6, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584334533-630845079-1113390744=:3625--
