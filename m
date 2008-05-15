Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 36ADDDDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 17:06:55 +1000 (EST)
Date: Thu, 15 May 2008 09:06:51 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: powercp-next build failure
Message-ID: <20080515070651.GA22079@aepfle.de>
References: <20080515145913.5436adb9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080515145913.5436adb9.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, Stephen Rothwell wrote:

> Today's linux-next build (sparc64 defconfig) fails like this:
> 
> drivers/of/device.c: In function `modalias_show':
> drivers/of/device.c:66: error: implicit declaration of function `of_device_get_modalias'
> 
> Caused by commit 140b932f8cb6cced10b96860651a198b1b89cbb9 ("[POWERPC]
> Create modalias file in sysfs for of_platform bus") from the powerpc-next
> tree as there is a definition and declaration of of_device_get_modalias
> only for powerpc.  I reverted that commit for today.

Better fix it up because my patch was for 2.6.25, and I cant follow
mainline due to time constraints.
