Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A73E668654
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 00:55:52 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 21 Oct 2005 17:11:02 +0200
References: <200510211417.49651.rupert@ces.ch>
	<200510211442.08477.rupert@ces.ch>
	<30B37541-CAC4-4052-B33D-AE1373C16FD3@freescale.com>
In-Reply-To: <30B37541-CAC4-4052-B33D-AE1373C16FD3@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510211711.02997.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] please use this one
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 October 2005 16:28, Kumar Gala wrote:
> The concept of PPC_HIGH_BATS is already some what handled with  
> CPU_FTR_HAS_HIGH_BATS.  I recommend you use this feature instead of  
> introducing another one as well as a compile time option.

CPU_FTR_HAS_HIGH_BATS only clears the high bats, but does
not attempt to use them. My patch will use them.

Rupert

> 
> - k
> 
