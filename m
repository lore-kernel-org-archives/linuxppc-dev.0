Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 704C5DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 19:16:11 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1433296fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 00:16:10 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: benh@kernel.crashing.org
In-Reply-To: <1201494324.6815.171.camel@pasglop>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201494324.6815.171.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jan 2008 09:16:06 +0100
Message-Id: <1201508166.5923.30.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	vatsa@linux.vnet.ibm.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 15:25 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2008-01-27 at 17:13 +0100, Michel Dänzer wrote:
> > 
> > > Do you see behavior change (from good->bad) immediately after
> > applying that patch 
> > > during your bisect process?
> > 
> > Yes, confirmed by trying that commit and its parent again.
> 
> Just to be paranoid... can you try with a different gcc version in case
> something gets miscompiled ?

Is that really necessary - after all,
810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 is related to process wakeup
behaviour?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
