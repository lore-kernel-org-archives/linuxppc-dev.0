Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.2.101]) by ozlabs.org (Postfix) with ESMTP id 0C55067B35
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 17:09:49 +1000 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j5L79kGZ006619
	for <linuxppc-embedded@ozlabs.org>; Tue, 21 Jun 2005 09:09:46 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42B7BD49.2000205@246tNt.com>
Date: Tue, 21 Jun 2005 09:10:01 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20050620193210.42378.qmail@web53505.mail.yahoo.com>
In-Reply-To: <20050620193210.42378.qmail@web53505.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] GCC4 compile fixes for mpc52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

roger blofeld wrote:
> Sylvain,
>  A quick patch to fix your tree for gcc4
> -rb
> 
> drivers/net/fec_mpc52xx/fec.c: In function 'fec_reinit':
> drivers/net/fec_mpc52xx/fec.c:525: error: invalid storage class for
> function 'fec_update_stat'
> 
> drivers/serial/mpc52xx_uart.c:707: error: static declaration of
> 'mpc52xx_uart_driver' follows non-static declaration
> drivers/serial/mpc52xx_uart.c:675: error: previous declaration of
> 'mpc52xx_uart_driver' was here
> 
> Signed off by Roger Blofeld <blofeldus@yahoo.com>
> 

Hi Roger,

Applied to my tree (with slight modification, I don't even see why
fec_update was declared there so I just removed it.)

The relevant part to the UART driver will be pushed along my next
set of update.


	Sylvain
