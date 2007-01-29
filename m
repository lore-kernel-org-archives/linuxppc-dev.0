Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 90180DE026
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 02:14:45 +1100 (EST)
Date: Mon, 29 Jan 2007 16:14:43 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
In-Reply-To: <200701260513.24010.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0701291611300.19906@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Jan 2007, Arnd Bergmann wrote:
> On Thursday 25 January 2007 18:48, Geert Uytterhoeven wrote:
> > +#ifdef PS3AV_DEBUG
> > +#define DPRINTK(fmt, args...) \
> > +	do { printk("ps3av " fmt, ## args); } while (0)
> > +#else
> > +#define DPRINTK(fmt, args...) do { } while (0)
> > +#endif
> 
> You should probably use the provided pr_debug or (better) dev_dbg
> macros to do that now.

Except that it's difficult to get a struct device * in drivers/ps3/ps3av_cmd.c.
And I prefer not to make ps3av_dev (which is currently static) global.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
