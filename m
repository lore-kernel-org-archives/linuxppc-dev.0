Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id AE79A68841
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2005 02:33:50 +1100 (EST)
Message-ID: <43872881.3010608@anagramm.de>
Date: Fri, 25 Nov 2005 16:06:41 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: hs@denx.de
References: <AHEILKONAKAEJPHNMOPNKEMMCDAA.hs@denx.de>
In-Reply-To: <AHEILKONAKAEJPHNMOPNKEMMCDAA.hs@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH]	MTD:	Add support for the PM82x Boards.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Heiko!

> i made the changes in the code you suggested to me.
> 
> Additional changes:
> - I now use the CFI interface (I tested it, and it seems OK
>   to me)

Datasheets should confirm the same.

Just in case you do the PM854 support anytime soon,
the i128J3C150 Flash supports CFI, too, which makes
these things also pretty simple.

Best greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
