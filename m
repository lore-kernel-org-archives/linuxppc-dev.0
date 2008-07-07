Return-Path: <jwboyer@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id 030ACDE70A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:35:56 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so180861ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 08:35:55 -0700 (PDT)
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu aware
	cpufreq governor
From: Josh Boyer <jwboyer@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807071659.23476.arnd@arndb.de>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
	<20080707162457.e5f3cb9d.sfr@canb.auug.org.au>
	<200807071659.23476.arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 07 Jul 2008 11:35:42 -0400
Message-Id: <1215444942.20774.50.camel@weaponx>
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

On Mon, 2008-07-07 at 16:59 +0200, Arnd Bergmann wrote:
> On Monday 07 July 2008, Stephen Rothwell wrote:
> > > +#define POLL_TIME    100000          /* in us */
> >                                               ^
> > How about μ ?
> 
> Not sure, how about µ instead? ;-)

Erm... don't get it.  You have identical characters here.

josh
