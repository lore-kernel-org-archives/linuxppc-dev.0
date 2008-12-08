Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18D6BDDDE0
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 18:38:12 +1100 (EST)
Subject: Re: The first 8GB harddrive limit for booting first iMacs. Help
	appreciated.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: anthony_renaud65@yahoo.com
In-Reply-To: <96913.5566.qm@web35204.mail.mud.yahoo.com>
References: <96913.5566.qm@web35204.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 18:38:06 +1100
Message-Id: <1228721886.7101.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-12-07 at 12:18 -0800, Anthony Renaud wrote:
> The problem is : Can Linux surpass this 8GB limit and be installed on
> partitions out of this
> 
> 8GB limit,and be bootable and run without problems? It seems a hardisk
> controller limitation
> 
> of these first iMac models.
> 
As long as the bootloader and kernels/initrds's is above that limit it's
fine. Make sure to stick the newworld boot partition down there and
create a smallish (100M ?) partition for the actual images (/boot)
instead of leaving them in your main filesystem.

Cheers,
Ben.
