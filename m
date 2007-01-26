Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2BFEDE066
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:46:32 +1100 (EST)
Message-ID: <45B9B1CD.4040600@garzik.org>
Date: Fri, 26 Jan 2007 02:46:21 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCHSET] libata: PATA driver	for Celleb
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
In-Reply-To: <200701260724.l0Q7OISY027645@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> Dear everyone.
> 
> Thank you for many useful comments.
> This is the latest patchset for the PATA controller of Celleb. 
> 
> This patchset consists of
> [1] add another IRQ calls (core and headers)
> [2] add another IRQ calls (libata drivers)
> [3] PATA driver for Celleb
> 
> And patch[3] depends on patch[1,2].
> 
> This patchset is based on the Tejun's "devres" git tree, which is
> available at the followin URL.

Everything looks great, thanks!

I'll apply this patchset immediately after applying Tejun's devres patchset.

	Jeff
