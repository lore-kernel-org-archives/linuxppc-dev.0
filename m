Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 61110DE28C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 17:28:24 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/2] port ndfc driver to of platform
Date: Fri, 15 Aug 2008 09:28:11 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
	<20080814192009.0a06eccb@lappy.seanm.ca>
	<20080815012402.72855c67@lappy.seanm.ca>
In-Reply-To: <20080815012402.72855c67@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808150928.12276.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 15 August 2008, Sean MacLennan wrote:
> Changes to the warp platform with the ndfc as an of platform device.
> The main changes are:
> 
> * move the NAND information to the DTS
> * remove warp-nand.c
> * remove rev A fixups from cuboot-warp.c
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
