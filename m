Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 10B5ADDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 03:00:49 +1100 (EST)
Date: Wed, 6 Feb 2008 10:01:57 -0600
From: Olof Johansson <olof@lixom.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Message-ID: <20080206160157.GA18228@lixom.net>
References: <1202300519-7294-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1202300519-7294-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 06, 2008 at 01:21:59PM +0100, Stefan Roese wrote:
> With the removal the the "rgmii-interface" device_type property from the
> dts files, the newemac driver needs an update to only rely on compatible
> property.

What about systems using an older dts, such as one kexec:ing from an
older kernel?

Just because the device tree source is distributed in the kernel tree
doesn't mean it can give up backwards compatibility.


-Olof
