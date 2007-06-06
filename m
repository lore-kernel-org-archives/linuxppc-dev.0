Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4F9BDDECA
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 19:28:25 +1000 (EST)
From: "kouish" <kou.ishizaki@toshiba.co.jp>
To: "'Paul Mackerras'" <paulus@samba.org>
Subject: RE: [PATCH] of_serial: ignore unknown serial port
Date: Wed, 6 Jun 2007 18:28:20 +0900
Message-Id: <200706060928.l569SAfF021931@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <18022.19709.50452.30370@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, segher@kernel.crash.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ishizaki Kou writes:
> 
> > Current of_serial driver assumes unknown serial port to be 8250. But
> > this behavior may cause fatal problems when the serial port is not
> > 8250. This patch corrects probe routine to ignore unknown 
> serial port.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Is this a bugfix that needs to go in 2.6.22?  Likewise, is your next
> patch (of_serial: add port type checking) needed in 2.6.22?
> 
> Paul.

Paul-san,

Thank you to ask me about our patches to of_serial driver.

We need the 'ignore unknown serial port' patch in 2.6.22 because
assuming an unknown port as 8250 may cause fatal problems on Celleb
with our new device tree which has 'serial' type device nodes. These
serial ports are not 8250.

On the other hand, we have no problem even if the 'of_serial: add port
type checking' patch will be merged in 2.6.23.

Best regards,
Kou Ishizaki
