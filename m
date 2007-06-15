Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4A7EDDF8B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:51:00 +1000 (EST)
Message-ID: <467309BA.8000009@garzik.org>
Date: Fri, 15 Jun 2007 17:50:50 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
References: <20070615120848.352093000@pademelon.sonytel.be>	<1181918159.25228.543.camel@pmac.infradead.org>	<Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
	<20070615.141720.112626963.davem@davemloft.net>
In-Reply-To: <20070615.141720.112626963.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

David Miller wrote:
> It's senseless to make people build new major/minor numbers for
> all these new quirky storage drivers.  People have to add support
> for the new major number to installers and all kinds of other
> tools.


FWIW that's why libata followed the path it did:  faking SCSI required 
the least amount of code for the maximal amount of existing storage 
driver and platform installer support.

Well, that and the fact that ATAPI is really SCSI, but that's offtopic 
for this thread.  :)

	Jeff
