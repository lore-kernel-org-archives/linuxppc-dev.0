Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49725DE032
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:29:07 +1000 (EST)
Message-ID: <4673047F.30808@garzik.org>
Date: Fri, 15 Jun 2007 17:28:31 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>,  Geert.Uytterhoeven@sonycom.com
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
References: <20070615120848.352093000@pademelon.sonytel.be>	<1181918159.25228.543.camel@pmac.infradead.org>	<Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
	<20070615.141720.112626963.davem@davemloft.net>
In-Reply-To: <20070615.141720.112626963.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: axboe@kernel.dk, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

>> Because no new fake SCSI drivers are accepted anymore.

If you can access the firmware/hypervisor code, have that provide SCSI. 
  Then the Linux driver piece is easy, obvious and flexible SCSI, and is 
not "fake."


> If the SCSI guys were smart, there would be a totally generic helper
> layer that allows anyone to hook into the SCSI layer as a virtual SCSI
> disk provider in like 10 lines of code. :-)

The SCSI target code gives you the capability to do that (the SCSI 
transport part, the virtual storage part is easy from there).

	Jeff
