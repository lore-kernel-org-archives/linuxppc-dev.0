Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7705ADDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 07:08:24 +1000 (EST)
Date: Fri, 17 Aug 2007 22:51:23 +0200 (MEST)
Message-Id: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: alan@lxorguk.ukuu.org.uk, jeff@garzik.org
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Cc: dwm@enoyolf.org, mikpe@it.uu.se, linux-ide@vger.kernel.org,
	bahadir.balban@gmail.com, linuxppc-dev@ozlabs.org, albertl@mail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
> > > Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> > 
> > Did this ever get resolved?
> 
> All went quiet so I assume its gone away ?

-ENOTIME

The regression is still there in 2.6.23-rc3 (I just checked),
but I haven't had time to debug it yet. I'll try to do something
about it this weekend.
