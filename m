Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 78568DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 18:51:06 +1000 (EST)
Date: Sat, 26 May 2007 10:51:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/7] ps3: Preallocate bootmem memory for the PS3 FLASH
	ROM storage driver
In-Reply-To: <1180132539.19517.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0705261050140.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.177254000@sonycom.com>
	<1180132539.19517.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 May 2007, Benjamin Herrenschmidt wrote:
> On Fri, 2007-05-25 at 10:36 +0200, Geert.Uytterhoeven@sonycom.com wrote:
> > -#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE)
> > +#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
> > +    defined(CONFIG_PS3_FLASH_MODULE) ||
> > defined(CONFIG_PS3_FLASH_MODULE)
> 
> As I said multiple times, imho, #ifdef CONFIG_xxx_MODULE in the kernel
> is always a bug.
> 
> You should always be able to build the module out of tree afteward and
> use it on a kernel that didn't have the CONFIG_xxx_MODULE set imho.

I know.

Do you know another way to allocate an aligned chunk of 256 KiB of physically
contiguous memory, possibly a long time after boot up?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
