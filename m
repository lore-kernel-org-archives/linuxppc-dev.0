Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D86B1A1D63
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:15 +1000 (AEST)
In-Reply-To: <1438273132-20926-6-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [05/27] macintosh: therm_windtunnel: Export I2C module alias
 information
Message-Id: <20150820083815.1D5101402AB@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:15 +1000 (AEST)
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

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cb0eefcc3271ea1d3704

cheers
