Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44E16B6F2B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 15:22:11 +1100 (EST)
Message-ID: <4B021650.6050708@garzik.org>
Date: Mon, 16 Nov 2009 22:19:44 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Vivek Mahajan <vivek.mahajan@freescale.com>
Subject: Re: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
In-Reply-To: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
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

On 11/16/2009 01:19 AM, Vivek Mahajan wrote:
> The following patch adds MSI support. Some platforms
> may have broken MSI, so those are defaulted to use
> legacy PCI interrupts.
>
> Signed-off-by: Vivek Mahajan<vivek.mahajan@freescale.com>
> ---
>   drivers/ata/sata_sil24.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)

applied
