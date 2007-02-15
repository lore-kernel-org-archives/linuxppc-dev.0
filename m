Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F17F9DDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 16:08:05 +1100 (EST)
Message-ID: <45D3EAA7.80805@garzik.org>
Date: Thu, 15 Feb 2007 00:07:51 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>	
	<45B9B1CD.4040600@garzik.org>
	<200702140518.l1E5IoWX010896@toshiba.co.jp>
	<1171430997.20192.136.camel@localhost.localdomain>
In-Reply-To: <1171430997.20192.136.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> 2.6.20 has been released and (I think) it is the time of merge-window
>> for 2.6.21. I want this patch to be merged at this time.
>> Please tell me if there are anything I should do.
> 
> FYI, Jeff, we have merged the rest of the celleb platform support in the
> 2.6.21 merge window, so it would be annoying if that didn't make it

agreed, that's on the list to get pushed


> (that and some spidernet fixes).

I'm totally confused about who the heck is the spidernet maintainer.  My 
inbox is pelted by spidernet driver updates from multiple people, and 
often the spidernet patches (regardless of author) receive comments that 
give me pause.  The MAINTAINERS file says

> SPIDERNET NETWORK DRIVER for CELL
> P:      Jim Lewis
> M:      jim@jklewis.com
> L:      netdev@vger.kernel.org
> S:      Supported

but I do not see patch roll-ups or much activity from him at all.  In 
practice, it seems like Linas does patchsets for spidernet, but there is 
also Jakob Osterkemp(sp?) and Ishizaki and....

My overall impression of spidernet development is that EVERYBODY is 
submitting patches at once, and expecting me to sort out the mess.  No 
thanks.

Speaking with one voice would be much appreciated.  And said speaker 
should patch the MAINTAINERS file to reflect reality.

	Jeff
