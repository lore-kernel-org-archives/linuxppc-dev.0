Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F186968829
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 07:30:25 +1100 (EST)
Date: Mon, 28 Nov 2005 12:48:00 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051128144800.GB25414@logos.cnet>
References: <438B379B.6090904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <438B379B.6090904@ru.mvista.com>
Cc: BLandau@nds.com, linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Adds MPC885ADS,
	MPC866ADS and MPC8272ADS-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2005 at 08:00:11PM +0300, Vitaly Bordug wrote:
> Added proper ppc_sys identification and fs_platform_info's for MPC 885ADS, 
> 866ADS and 8272ADS. Assuming setbitsXX/clrbitsXX patch is applied.
> 
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Looks great now for the parts I can comment on...
