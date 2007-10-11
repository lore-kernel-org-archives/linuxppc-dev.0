Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7D277DE0D4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:11:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: Add legacy serial support for OPB with flattened
	device tree.
Date: Thu, 11 Oct 2007 23:10:49 +0200
References: <20071011190925.GA22704@ru.mvista.com>
In-Reply-To: <20071011190925.GA22704@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710112310.50582.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 October 2007, Valentine Barshak wrote:
> Currently find_legacy_serial_ports() can find no serial ports on the OPB
> with flattened device. Thus no legacy boot console can be initialized.
> Just the early udbg console works, which is initialized with udbg_init_44x_as1
> on the UART's physical address specified in kernel config. This happens
> because we look for ns16750 serial devices only and expect opb node to have
> a device type property. This patch makes it look for ns16550-compatible
> devices and use of_device_is_compatible() for opb in case device type is not
> specified.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Looks correct for QS21 now.

Acked-by: Arnd Bergmann <arnd@arndb.de>
