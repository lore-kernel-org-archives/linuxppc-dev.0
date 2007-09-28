Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C704DDDF6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 02:34:44 +1000 (EST)
In-Reply-To: <1190932629.6158.37.camel@pasglop>
References: <20070927.202207.-1300525707.kouish@swc.toshiba.co.jp>
	<1190931617.6158.29.camel@pasglop>
	<1190932629.6158.37.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <90f98bce38007cef1fb84d7088ffd95d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
Date: Fri, 28 Sep 2007 18:33:06 +0200
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also, you may want to try adding --ffixed-r13 to the CFLAGS in the
> makefile and let us know if it makes a difference... r13 is marked
> reserved by the ABI but segher seems to imply that gcc may decide to 
> ues
> it anyway (ouch !)

That's what I thought for a second, but I misread the GCC sources.

This however brings up another point: for PPC32, -ffixed-r2 is
superfluous for all the same reasons as why we don't need -ffixed-r13
on PPC64.  Is there any reason to keep it or is this just historical
cruft?


Segher
