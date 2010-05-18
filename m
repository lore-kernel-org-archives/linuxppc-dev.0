Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63ABAB7D93
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 14:25:29 +1000 (EST)
Subject: Re: [PATCH] 85xx: Enable support for ports 3 and 4 on 8548 CDS
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1269913148-6450-1-git-send-email-afleming@freescale.com>
Date: Mon, 17 May 2010 23:25:22 -0500
Message-Id: <339029CA-3AD6-43BC-8C34-C1454F72DDB3@kernel.crashing.org>
References: <1269913148-6450-1-git-send-email-afleming@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 29, 2010, at 8:39 PM, Andy Fleming wrote:

> I believe support was disabled due to issues with earlier versions of
> the board/processor.  At worst, adding the ports back into the device
> tree should result in enabling ports that don't work on older systems,
> so the default should be to enable them.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8548cds.dts |    4 ----
> 1 files changed, 0 insertions(+), 4 deletions(-)

applied to next

- k
