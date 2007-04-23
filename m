Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FC50DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:20:07 +1000 (EST)
In-Reply-To: <5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
References: <20070423144052.261f68ad.kim.phillips@freescale.com>
	<5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <affe73a697668fc2d44e43dd097a3e96@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v4] powerpc: document phy-connection-type property
Date: Mon, 23 Apr 2007 23:19:02 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Since ucc_geth is being migrated to use the phylib, the existing
>> (undocumented) 'interface' property is being deprecated in favour
>> of 'phy-connection-type'.
>
> Okay.

To be perfectly clear about this -- the only reason to
not have it in the PHY node instead is that supposedly
a PHY can be connected on multiple different kinds of
interface at the same time (physically).  Don't ask me
who designs boards like that, but there you have it.


Segher
