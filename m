Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A8A15DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 02:25:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] port ndfc driver to arch/powerpc
Date: Mon, 4 Aug 2008 18:25:02 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
In-Reply-To: <20080801233000.3574434f@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808041825.02314.arnd@arndb.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 02 August 2008, Sean MacLennan wrote:
> This is a port of the ndfc driver from arch/ppc to arch/powerpc. Since
> arch/ppc has been removed, references to CONFIG_PPC_MERGE where removed.
> 
> For an example of how to use the driver see
> arch/powerpc/platforms/44x/warp-nand.c .
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Shouldn't this instead use the device tree, like fsl_elbc, fsl_upm
and pasemi_nand do?
It feels awfully backwards to hardcode this stuff in the platform
source code.

	Arnd <><
