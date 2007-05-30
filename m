Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03699DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:28:31 +1000 (EST)
In-Reply-To: <20070530013718.GB21955@localhost.localdomain>
References: <20070530013718.GB21955@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9db95465199af5090a48726476677a2a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with device tree representation of TSI-1xx bridges
Date: Wed, 30 May 2007 15:28:24 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch fixes some problems with the way the some things
> represented in the device tree for the Holly and Taiga boards.  This
> means changes both to the dts files, and to the code which
> instantiates the tsi108 ethernet platform devices based on the device
> tree.

Looks fine now :-)

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
