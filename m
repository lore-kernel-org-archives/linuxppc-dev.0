Return-Path: <jeff@garzik.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74729B7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 16:37:59 +1000 (EST)
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E24FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 16:37:58 +1000 (EST)
Message-ID: <4AA9F038.6030207@garzik.org>
Date: Fri, 11 Sep 2009 02:37:44 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: ashish kalra <ashish.kalra@freescale.com>
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
In-Reply-To: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2009 09:26 AM, ashish kalra wrote:
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient & device and PMP detection more reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726, Sil4726 &
> Exar PMP controllers.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>

can you rediff this and 'AN' support against latest upstream?
