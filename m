Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 291DFDDEE4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 23:32:51 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0706042159090.3653@poirot.grange>
References: <Pine.LNX.4.60.0706042159090.3653@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b7b230e13a4d74b2af967ca2e7fae400@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add rtc-on-i2c node to two linkstation device-trees
Date: Thu, 7 Jun 2007 15:32:40 +0200
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If approved here, this patch will follow the previous one for i2c-of
> definitions to the -mm tree, to fix linkstation breakage caused by
> converting rtc-rs5c372 driver to the new i2c api.

The changes look good to me.


Segher
