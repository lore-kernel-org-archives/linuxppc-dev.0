Return-Path: <SRS0=EjjG=QD=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 01FD2DDEC4
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 00:03:52 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC440EPx on Sequoia: /proc/iomem acts weird
Date: Sat, 10 Nov 2007 14:03:48 +0100
References: <4734A72B.2070104@harris.com> <20071109123522.072bc1d8@weaponx>
	<4734AAFC.8080907@harris.com>
In-Reply-To: <4734AAFC.8080907@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711101403.48792.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Steve,

On Friday 09 November 2007, Steven A. Falco wrote:
> I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.
> Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it
> further.

Is this arch/ppc or arch/powerpc? I remember fixing this a while ago in 
arch/ppc:

commit 67a35ce785b1d11d09bf528c166ea26d489a4bd6
Author: Stefan Roese <sr@denx.de>
Date:   Thu Aug 2 14:15:22 2007 +0200

    ppc: Fix problem with recursive NDFC platform_device resource management

    This change fixes a problem with a resursive platform_device resource
    management of the AMCC 4xx NDFC. Without this fix a "cat /proc/iomem"
    leads to an infinite loop of printing the "ndfc-nand.0" resource.

    Signed-off-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
