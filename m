Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28C4DDDDA2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 05:42:41 +1100 (EST)
Message-ID: <49D5071D.50001@freescale.com>
Date: Thu, 02 Apr 2009 13:42:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] QE USB Host Integration for MPC832x
References: <1238622396-9768-1-git-send-email-marcel@ziswiler.com>
	<20090402183357.GA29050@oksana.dev.rtsoft.ru>
	<20090402183631.GA6699@oksana.dev.rtsoft.ru>
In-Reply-To: <20090402183631.GA6699@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Marcel Ziswiler <marcel@ziswiler.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Oh, I was wrong. fsl_qe_udc driver uses mpc8360 compatible for
> matching, so you can't remove it. :-/

Ugh, that's a bug in the driver then.

My understanding is that the only MPC8323 QE microcode update is the one
for UART.  If there are any updates to any other QE devices for standard
functionality, I'm not aware of any.

-- 
Timur Tabi
Linux kernel developer at Freescale
