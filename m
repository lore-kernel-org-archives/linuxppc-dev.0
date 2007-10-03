Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D32E0DDE46
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 03:47:24 +1000 (EST)
Message-ID: <4703D5A5.1080204@pobox.com>
Date: Wed, 03 Oct 2007 13:47:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [11/11] pasemi_mac: enable iommu support
References: <20071002212421.GA2282@lixom.net> <20071002212818.GL2282@lixom.net>
In-Reply-To: <20071002212818.GL2282@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> pasemi_mac: use buffer index pointer in clean_rx()
> 
> Use the new features in B0 for buffer ring index on the receive side. This
> means we no longer have to search in the ring for where the buffer
> came from.
> 
> Also cleanup the RX cleaning side a little, while I was at it.
> 
> Note: Pre-B0 hardware is no longer supported, and needs a pile of other
> workarounds that are not being submitted for mainline inclusion. So the
> fact that this breaks old hardware is not a problem at this time.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

You sent patch #10 against as patch #11 :)
