Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D8A7CDE014
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 01:10:18 +1100 (EST)
Date: Mon, 29 Jan 2007 15:10:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
In-Reply-To: <20070126031236.GG18537@lst.de>
Message-ID: <Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Jan 2007, Christoph Hellwig wrote:
> Btw, the Kconfig and/or top of file comment really needs a better
> explanation what this "driver" is for.  I also wonder why it's

What about `PS3 AV settings driver library' instead of `PS3 AV controller
support'?

> selectable in Kconfig at all given it has no visible user interface.
> Shouldn't the users of the exported symbols simply pull it in or the
> code made part of the unconditional build bits in the ps3 platform
> directory?

We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that better?
I prefer not to make it unconditional, as people who want to run their PS3s
headless don't need it.

I guess you want us to do the same for the virtual uart, i.e. let PS3_PS3AV and
PS3_SYS_MANAGER select PS3_VUART?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
