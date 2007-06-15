Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6455CDDFE3
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:37:46 +1000 (EST)
Date: Fri, 15 Jun 2007 14:37:54 -0700 (PDT)
Message-Id: <20070615.143754.28790010.davem@davemloft.net>
To: jeff@garzik.org
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <4673047F.30808@garzik.org>
References: <Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
	<20070615.141720.112626963.davem@davemloft.net>
	<4673047F.30808@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: axboe@kernel.dk, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeff Garzik <jeff@garzik.org>
Date: Fri, 15 Jun 2007 17:28:31 -0400

> David Miller wrote:
> > If the SCSI guys were smart, there would be a totally generic helper
> > layer that allows anyone to hook into the SCSI layer as a virtual SCSI
> > disk provider in like 10 lines of code. :-)
> 
> The SCSI target code gives you the capability to do that (the SCSI 
> transport part, the virtual storage part is easy from there).

I don't get to control the server side in my case, I'm a client
talking to something with a pre-determined interface.
