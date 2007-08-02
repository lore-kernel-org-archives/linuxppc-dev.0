Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 59DAEDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 01:28:58 +1000 (EST)
Date: Thu, 2 Aug 2007 19:27:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [SPI][POWERPC] spi_mpc83xx: in "QE mode" spiclk is
	sysclk/2
Message-ID: <20070802152746.GA26585@localhost.localdomain>
References: <20070802142641.GA6309@localhost.localdomain>
	<59836CD3-C46E-4B51-8FFE-5F40107CAA85@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <59836CD3-C46E-4B51-8FFE-5F40107CAA85@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 10:19:17AM -0500, Kumar Gala wrote:
>
> On Aug 2, 2007, at 9:26 AM, Anton Vorontsov wrote:
>
>> For MPC8349E input to SPIBRG is SYSCLK, but it's SYSCLK/2 for
>> MPC8323E (running in so-called "QE mode").
>
> QE mode or the SPI in QE running in CPU mode?

Yeah, "qe_mode" variable is confusing, but it wasn't me who introduced
it. ;-) So, "the SPI in QE running in CPU mode" is correct.

[ Unrelated to that particular patch.

Probably qe_mode should be renamed to something better, maybe
spi_in_qe? Or we could back to discussion about auto detecting it
somehow. ]

> - k

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
