Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A7A4DDE35
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 01:44:16 +1000 (EST)
In-Reply-To: <200705030948.03984.arnd@arndb.de>
References: <20070503065435.4533.64938.stgit@localhost.localdomain>
	<200705030948.03984.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5a7e02f6d1520d8ad02e28ace218981c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Thu, 3 May 2007 17:43:38 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +               pcmcia@0080 {

>> +                       compatible = "8xx";

> The compatible property should be a little more specific, imho. Since 
> there
> are differences in how things are done depending on the board, it 
> would be
> good to tell the exact method from the pcmcia node itself.

Just "8xx" isn't good enough -- at a very minimum it
needs to say this is a PCMCIA controller!

> For example, you could make this
>
> 	compatible = "8xx\0mpc885ads";

"mpc885ads-pcmcia\0mpc8xx-pcmcia" or something like that.


Segher
