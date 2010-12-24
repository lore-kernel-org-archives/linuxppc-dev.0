Return-Path: <jgpobox@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) by ozlabs.org (Postfix) with ESMTP id 68FBAB70A3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Dec 2010 05:38:50 +1100 (EST)
Received: by qwj8 with SMTP id 8so9609230qwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Dec 2010 10:38:48 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4D14E8B3.8070605@pobox.com>
Date: Fri, 24 Dec 2010 13:38:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND] pata_mpc52xx: driver needs BMDMA
References: <1293033011-19265-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1293033011-19265-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/22/2010 10:50 AM, Wolfram Sang wrote:
> Found by this build-error if BMDMA is disabled:
>
> drivers/ata/pata_mpc52xx.c: In function 'mpc52xx_ata_init_one':
> drivers/ata/pata_mpc52xx.c:662: error: 'ata_bmdma_interrupt' undeclared (first use in this function)
> ...
>
> Move the Kconfig entry to the proper location as needed since
> 9a7780c9acb821fe1c2b6fc53f74cc2556ff5364 (libata-sff: make BMDMA optional)
>
> Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
> ---
>
> This is a build-failure, so fixing it before 2.6.37 would be great.
>
>   drivers/ata/Kconfig  |   20 ++++++++++----------
>   drivers/ata/Makefile |    2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)

applied
