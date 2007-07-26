Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D723DDECC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 01:14:40 +1000 (EST)
Message-ID: <46A8BA58.4010208@freescale.com>
Date: Thu, 26 Jul 2007 10:14:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: Fix definition of global-utilites structure
	for 86xx
References: <11853846332917-git-send-email-timur@freescale.com>
	<8CEA1441-8408-48A9-A023-F072FBC3EEE2@kernel.crashing.org>
In-Reply-To: <8CEA1441-8408-48A9-A023-F072FBC3EEE2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Why don't we remove this completely, nothing uses it?

Should I respin the patch to include updates to mpc86xx_restart() to use it?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
