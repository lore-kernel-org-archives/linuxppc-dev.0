Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 370701007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 00:46:42 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 14:41:27 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911191401.37531.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE44@Exchange.discretix.com>
In-Reply-To: <8B957E110B62714A84290A01A597805F05D2AE44@Exchange.discretix.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911191441.27581.arnd@arndb.de>
Cc: Alon Ziv <alonz@discretix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 November 2009, Alon Ziv wrote:
> Is the following better?
> 
> ---
> [PATCH] Xilinx 16550 UART is actually 16550A-compatible
> 

Yes, that's better because it's guaranteed not to break any
other system, while fixing yours.

I'd still add support for the compatible="ns16550a" property
so that we do the right thing for future systems.

	Arnd <><
