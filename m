Return-Path: <jesper.juhl@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id 33BA9688C6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2005 05:59:20 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id j2so1813437nzf
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2005 10:59:19 -0800 (PST)
Message-ID: <9a8748490512131059m54cc56faueaab6ddf0f18520e@mail.gmail.com>
Date: Tue, 13 Dec 2005 19:59:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.62.0512131926530.17990@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
	<20051211193118.GR23349@stusta.de>
	<20051211194437.GB22537@flint.arm.linux.org.uk>
	<20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de>
	<20051213140001.GG23349@stusta.de>
	<20051213173112.GA24094@flint.arm.linux.org.uk>
	<20051213180551.GN23349@stusta.de>
	<Pine.LNX.4.62.0512131926530.17990@pademelon.sonytel.be>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, grundler@parisc-linux.org,
	matthew@wil.cx, Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	lethal@linux-sh.org, linux-mtd@lists.infradead.org,
	dwmw2@infradead.org, kkojima@rr.iij4u.or.jp, parisc-linux@parisc-linux.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/13/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 13 Dec 2005, Adrian Bunk wrote:
> > Do not allow people to create configurations with CONFIG_BROKEN=3Dy.
> >
> > The sole reason for CONFIG_BROKEN=3Dy would be if you are working on
> > fixing a broken driver, but in this case editing the Kconfig file is
> > trivial.
> >
> > Never ever should a user enable CONFIG_BROKEN.
>                       ^^^^
> OK, a user, not an expert. Let's assume users don't enable EXPERIMENTAL.
>
> But I'd like to at least have the possibility to enable broken drivers, e=
ven if
> it's just for compile regression tests.
>
I agree, and it's very convenient to be able to enable it in
menuconfig etc. Perhaps CONFIG_BROKEN should just be moved to kernel
hacking instead...?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
