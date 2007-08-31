Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64400DDFA6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 23:54:29 +1000 (EST)
Message-ID: <46D81D8F.3060208@pobox.com>
Date: Fri, 31 Aug 2007 09:54:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [02/10] pasemi_mac: Stop using the pci config space
	accessors for register read/writes
References: <20070817205413.548020000@lixom.net>
	<20070822141248.GC16830@lixom.net>
	<20070823181310.GB31882@lixom.net>
In-Reply-To: <20070823181310.GB31882@lixom.net>
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

Olof Johansson wrote:
> Move away from using the pci config access functions for simple register
> access.  Our device has all of the registers in the config space (hey,
> from the hardware point of view it looks reasonable :-), so we need to
> somehow get to it. Newer firmwares have it in the device tree such that
> we can just get it and ioremap it there (in case it ever moves in future
> products). For now, provide a hardcoded fallback for older firmwares.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied 2-10
