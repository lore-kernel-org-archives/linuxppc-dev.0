Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6D4C3DE024
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 17:28:57 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 14/14] ps3: ps3_defconfig updates
Date: Thu, 25 Jan 2007 07:28:46 +0100
References: <45B818A0.9010604@am.sony.com>
In-Reply-To: <45B818A0.9010604@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250728.46447.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:40, Geoff Levand wrote:
> Updates for ps3_defconfig.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

> +# CONFIG_USB_USBNET_MII is not set
> +# CONFIG_USB_USBNET is not set

Do you mind switching on usbnet and mcs7830 in defconfig for me?
It might make life easier for me if I have to do something on
the gelic_net driver ;-)

	Arnd <><
