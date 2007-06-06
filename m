Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18022.19709.50452.30370@cargo.ozlabs.ibm.com>
Date: Wed, 6 Jun 2007 15:58:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] of_serial: ignore unknown serial port
In-Reply-To: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
References: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou writes:

> Current of_serial driver assumes unknown serial port to be 8250. But
> this behavior may cause fatal problems when the serial port is not
> 8250. This patch corrects probe routine to ignore unknown serial port.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Cc: Arnd Bergmann <arnd@arndb.de>

Is this a bugfix that needs to go in 2.6.22?  Likewise, is your next
patch (of_serial: add port type checking) needed in 2.6.22?

Paul.
