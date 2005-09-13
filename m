Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72FD6680F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 18:52:20 +1000 (EST)
Date: Tue, 13 Sep 2005 09:52:11 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: prabha.j@tcs.com
Message-Id: <20050913095211.3d477dc2.ajz@cambridgebroadband.com>
In-Reply-To: <OF29F8842B.21C92BA3-ON6525707B.0016F392-6525707B.0017A365@tcs.com>
References: <OF29F8842B.21C92BA3-ON6525707B.0016F392-6525707B.0017A365@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help on 8260 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 13 Sep 2005 09:48:26 +0530
prabha.j@tcs.com wrote:

> With default settings i have built both the kernel and u-boot image. But i 
> want to do according to the board.
> Please give me some advice on this.

Don't use the defaults.  The configuration is already done for you -

In u-boot-<version>:

	make MPC8260_config
	...

In linux-<version>:


	make ads8260_config
	make oldconfig

Also, I suggest you read the DULG wiki on using linux with u-boot in PPC environments.  It's mostly
aimed at the 8xx but it all still applies to the 82xx:

	http://www.denx.de/twiki/bin/view/DULG/Manual

Alex
