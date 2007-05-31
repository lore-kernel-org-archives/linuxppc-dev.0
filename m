Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id C111ADDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 20:46:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] of_serial: add port type checking
Date: Thu, 31 May 2007 12:46:19 +0200
References: <200705310933.l4V9X4Pl009909@toshiba.co.jp>
In-Reply-To: <200705310933.l4V9X4Pl009909@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705311246.20197.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 31 May 2007, Ishizaki Kou wrote:
> 
> Currently, of_serial driver supports only 8250 compatible ports, but
> prepares that others can easily be added. Yet unregister routine
> assumes port is 8250. This patch corrects unregister routine to check
> port type.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
