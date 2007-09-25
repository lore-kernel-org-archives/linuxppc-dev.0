Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 0B637DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:48:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1110654uge
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 07:48:03 -0700 (PDT)
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow use on MPC85xx
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 25 Sep 2007 16:48:00 +0200
In-Reply-To: <20070925143531.GG5323@localhost.localdomain> (Anton Vorontsov's
	message of "Tue\, 25 Sep 2007 18\:35\:31 +0400")
Message-ID: <874phiol7j.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,
 
 Anton>  config SPI_MPC83xx
 Anton>  	tristate "Freescale MPC83xx SPI controller"
 Anton> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
 Anton> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
 Anton>  	select SPI_BITBANG
 Anton>  	help
 Anton>  	  This enables using the Freescale MPC83xx SPI controller in master

Please also update the help text.

-- 
Bye, Peter Korsgaard
