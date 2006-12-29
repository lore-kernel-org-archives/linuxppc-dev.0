Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF6D2DDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 09:45:14 +1100 (EST)
In-Reply-To: <006401c72a19$7680a5c0$1e67a8c0@Jocke>
References: <006401c72a19$7680a5c0$1e67a8c0@Jocke>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <48D9A818-DDBF-4DF1-9F79-AE93EC476511@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc83xx_restart() buggy
Date: Fri, 29 Dec 2006 16:45:30 -0600
To: Tjernlund <tjernlund@tjernlund.se>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 27, 2006, at 6:45 PM, Tjernlund wrote:

> mpc83xx_restart() uses ioremap(), which doesn't like
> beeing called while in IRQ context.
>
> Calling mpc83xx_restart() in IRQ context yields OOPS
> which calls mpc83xx_restart() again and the loop never
> termintes.

This is interesting, I know I've seen restart work properly w/o an  
oops.  How are you causing the restart?

- k
