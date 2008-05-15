Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4F0D8DDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 19:59:30 +1000 (EST)
Date: Thu, 15 May 2008 02:59:24 -0700 (PDT)
Message-Id: <20080515.025924.244953352.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: linux-next: powercp-next build failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <18476.327.432007.66792@cargo.ozlabs.ibm.com>
References: <20080515145913.5436adb9.sfr@canb.auug.org.au>
	<18476.327.432007.66792@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, linux-next@vger.kernel.org,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 15 May 2008 19:24:23 +1000

> > drivers/of/device.c: In function `modalias_show':
> > drivers/of/device.c:66: error: implicit declaration of function `of_device_get_modalias'
> 
> Dave, how would you prefer to fix this?  We could move
> of_device_get_modalias into drivers/of/device.c, or I could simply
> revert that commit.

Feel free to move that function into drivers/of/device.c
