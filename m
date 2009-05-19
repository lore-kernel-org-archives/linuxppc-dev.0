Return-Path: <kosmo@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8453DE0D5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 18:05:07 +1000 (EST)
From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo@semihalf.com>
To: "Hongjun Chen" <r66092@freescale.com>
Subject: Re: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.
Date: Tue, 19 May 2009 10:03:42 +0200
References: <1241640919-4650-12-git-send-email-wd@denx.de>
	<200905190937411866001@freescale.com>
In-Reply-To: <200905190937411866001@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200905191003.42964.kosmo@semihalf.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tuesday 19 May 2009 03:37:47 Hongjun Chen wrote:
> Since you have reuse most part of our BSP, why should you reinvent wheel
> for MPC512x DMA? We have one ready DMA driver, which has been used by AC9=
7,
> ATA, VIU etc.
>

Answer is simple. The old one does not fit Linux DMA API. New one uses=20
existing infrastructure which makes DMA engine aviable for existing consume=
rs
in Linux kernel. For example network stack. Support for I/O <-> memory=20
transfers will be added when more consumers arrive.

=2D-=20
Best Regards.
Piotr Zi=EAcik
