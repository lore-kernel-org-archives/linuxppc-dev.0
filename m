Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0A87DDDFFD
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:55:41 +1000 (EST)
Date: Fri, 15 Jun 2007 14:55:59 -0700 (PDT)
Message-Id: <20070615.145559.88477207.davem@davemloft.net>
To: jeff@garzik.org
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <467309BA.8000009@garzik.org>
References: <Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
	<20070615.141720.112626963.davem@davemloft.net>
	<467309BA.8000009@garzik.org>
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
Date: Fri, 15 Jun 2007 17:50:50 -0400

> FWIW that's why libata followed the path it did:  faking SCSI required 
> the least amount of code for the maximal amount of existing storage 
> driver and platform installer support.
> 
> Well, that and the fact that ATAPI is really SCSI, but that's offtopic 
> for this thread.  :)

Yep I absolutely understand that, and for my case as well it's
nearly always SCSI underneath that's why you can send SCSI
commands passthru to the virtual disk server if you like.
