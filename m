Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4714EDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 03:32:01 +1000 (EST)
Message-ID: <47125276.7070703@garzik.org>
Date: Sun, 14 Oct 2007 13:31:34 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
References: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
In-Reply-To: <200708172051.l7HKpNtq009682@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Mikael Pettersson wrote:
> On Thu, 16 Aug 2007 21:19:40 +0100, Alan Cox wrote:
>>>> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
>>> Did this ever get resolved?
>> All went quiet so I assume its gone away ?
> 
> -ENOTIME
> 
> The regression is still there in 2.6.23-rc3 (I just checked),
> but I haven't had time to debug it yet. I'll try to do something
> about it this weekend.

Still broken?

	Jeff
