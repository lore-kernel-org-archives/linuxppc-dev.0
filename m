Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28B701A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 20:24:49 +1000 (AEST)
In-Reply-To: <1438273132-20926-6-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [05/27] macintosh: therm_windtunnel: Export I2C module alias
 information
Message-Id: <20150818102449.06B531406A9@ozlabs.org>
Date: Tue, 18 Aug 2015 20:24:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-30-07 at 16:18:30 UTC, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So the driver needs to export the I2C table and this
> be built into the module or udev won't have the necessary information
> to auto load the correct module when the device is added.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/macintosh/therm_windtunnel.c | 1 +
>  1 file changed, 1 insertion(+)

Who are you expecting to merge this?

cheers
