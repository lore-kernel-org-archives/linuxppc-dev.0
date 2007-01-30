Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 5D0F1DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:39:32 +1100 (EST)
Date: Tue, 30 Jan 2007 20:39:30 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
In-Reply-To: <E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0701302039090.7678@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
	<20070129161502.GA32313@lst.de>
	<E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>,
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

On Tue, 30 Jan 2007, Segher Boessenkool wrote:
> >> We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that  
> >> better?
> >> I prefer not to make it unconditional, as people who want to run  
> >> their PS3s
> >> headless don't need it.
> >
> > Ok.  Even better would be handling it on the makefile level, by doing
> >
> > obj-$(CONFIG_FB_PS3)	+= ps3_av.o
> > obj-$(CONFIG_SND_PS3)	+= ps3_av.o
> 
> I don't think Kbuild will be too happy with that.  Or does
> it filter out duplicate files everywhere (dep, build, link)?

Yes, it filters out duplicates. But I went for `select' instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
