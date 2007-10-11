Return-Path: <SRS0=DCot=PF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 09320DDFEE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 22:22:16 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Kilauea DTS
Date: Thu, 11 Oct 2007 14:22:35 +0200
References: <200710081110.16447.sr@denx.de> <200710111402.12449.sr@denx.de>
	<1192104819.5534.109.camel@localhost.localdomain>
In-Reply-To: <1192104819.5534.109.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710111422.36070.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

On Thursday 11 October 2007, Josh Boyer wrote:
> Ok, so how does the DTS file from the kernel get to U-Boot?  Since there
> is no defconfig provided and no wrapper bits, I'm assuming this port
> takes a raw uImage.  Is that correct?

Yes, correct.

> If so, do you expect a separate 
> DTB file to be built for this that is passed to U-Boot?

For booting on such a platform the "raw" uImage is needed plus the dtb file, 
generated from the dts file in arch/powerpc. At least that's how I'm doing 
it, and I'm still very new to this device tree stuff.

Best regards,
Stefan
