Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id C8C8767B57
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 05:43:57 +1000 (EST)
Date: Mon, 10 Jul 2006 21:43:52 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: ppc -> powerpc porting
In-Reply-To: <20060710214158.1d8dcf2c@vitb.ru.mvista.com>
Message-ID: <Pine.LNX.4.60.0607102135330.10561@poirot.grange>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Jul 2006, Vitaly Bordug wrote:

> On Mon, 10 Jul 2006 12:14:24 -0500
> "Rune Torgersen" <runet@innovsys.com> wrote:
> 
> > To make my life a little easier: Does anybody have a list of stuff to
> > watch out for/need to do when porting a board from ppc to powerpc?
> > The board uses a Freescale 8265 and runs under 2.6.17, using platfrom
> > device support for accessing fs_enet driver.

Look at Documentation/powerpc/booting-without-of.txt - there's a section 
on that. I am attempting the same sort of conversion for an embedded 
mpc8241 board, so, would be glad to share ideas / experiences, I think, we 
won't offend others if we just discuss our problems on this list, maybe 
even somebody else will find it useful:-)) The first step I am trying to 
perform is to switch to the device-tree boot. Does your board already use 
it or does it have OF?

> We have mpc8272 under arch/powerpc as work-in-progress, latest fs_enet being merged now.
> 
> I think it'll be a week or 2 before first submit, so it may make sense just to wait a bit :)

Yep, you could wait, but, you see, an example will be great, but, I am 
afraid, all ports will be pretty different, so, we'll all have to "invent 
the wheel." Is your code available somewhere in some repository to have a 
look at?

Thanks
Guennadi
---
Guennadi Liakhovetski
