Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id F0D11DE58B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 07:18:14 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so562042rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 14:18:13 -0700 (PDT)
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu
	aware	cpufreq governor
From: Josh Boyer <jwboyer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807072315.13666.arnd@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<200807071659.23476.arnd@arndb.de> <1215444942.20774.50.camel@weaponx>
	<200807072315.13666.arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 07 Jul 2008 17:17:57 -0400
Message-Id: <1215465477.20774.65.camel@weaponx>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 23:15 +0200, Arnd Bergmann wrote:
> On Monday 07 July 2008, Josh Boyer wrote:
> > 0% probability of being spam.
> > 
> > Full report:
> > No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.2.4  
> > On Mon, 2008-07-07 at 16:59 +0200, Arnd Bergmann wrote:
> > > On Monday 07 July 2008, Stephen Rothwell wrote:
> > > > > +#define POLL_TIME    100000          /* in us */
> > > >                                               ^
> > > > How about μ ?
> > > 
> > > Not sure, how about µ instead? ;-)
> > 
> > Erm... don't get it.  You have identical characters here.
> 
> That depends on the tool you use to look at it.
> 
> Stephen wrote a Unicode character U+03BC from the Greek alphabet part of
> unicode, I wrote unicode character U+00B5 from the Latin-1 code page.
> In my mail client, latin-1 characters get rendered in the default font,
> but it has to change the font for less common scripts.

I thought Unicode was supposed to _improve_ stuff like that... ;)

josh
