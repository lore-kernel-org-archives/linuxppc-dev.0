Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D01A2DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:27:40 +1000 (EST)
Message-ID: <469BF0D6.5000601@garzik.org>
Date: Mon, 16 Jul 2007 18:27:34 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
Subject: Re: [PATCH] Fix Tsi108 ethernet driver performance
References: <1B5F013528140F45B5C671039279CA5701F834BB@NANUK.pc.tundra.com>
In-Reply-To: <1B5F013528140F45B5C671039279CA5701F834BB@NANUK.pc.tundra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> From: Alexandre Bounine <alexandreb@tundra.com>
> 
> This patch improves performance of the Tsi108 Ethernet driver by
> changing interrupt handling for frame receive path. It reduces number of
> interrupts generated for received frames and therefore lowers CPU
> utilization by the device driver.
>    
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>

Look into NAPI...
