Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89A2ADDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 05:30:26 +1000 (EST)
Date: Sun, 14 Oct 2007 20:33:09 +0200 (MEST)
Message-Id: <200710141833.l9EIX9fZ021807@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org, mikpe@it.uu.se
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Cc: dwm@enoyolf.org, linux-ide@vger.kernel.org, bahadir.balban@gmail.com,
	linuxppc-dev@ozlabs.org, albertl@mail.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 14 Oct 2007 13:31:34 -0400, Jeff Garzik wrote:
> Mikael Pettersson wrote:
> > On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
> >>>> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> >>> Did this ever get resolved?
> >> All went quiet so I assume its gone away ?
> > 
> > -ENOTIME
> > 
> > The regression is still there in 2.6.23-rc3 (I just checked),
> > but I haven't had time to debug it yet. I'll try to do something
> > about it this weekend.
> 
> Still broken?

No, my fix was included in 2.6.23-rc4.
