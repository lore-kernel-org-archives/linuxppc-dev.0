Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1821ADDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 18:21:12 +1100 (EST)
Date: Fri, 21 Nov 2008 08:21:02 +0100
From: Benjamin Krill <ben@codiert.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081121072101.GP24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de>
	<20081121003545.GC13049@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20081121003545.GC13049@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* David Gibson | 2008-11-21 11:35:45 [+1100]:

>
>Uh.. registers as port number 84??  What's this random number about?
>
It's just the next free number in serial_core.h.

 Ben
