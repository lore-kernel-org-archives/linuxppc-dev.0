Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3100DDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 19:57:48 +1000 (EST)
In-Reply-To: <1182298510.5674.357.camel@rhino>
References: <1182298510.5674.357.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5492541032afa2123835334cdf42966d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add a check for keyboard/mouse device nodes in
	check_legacy_ioport()
Date: Wed, 20 Jun 2007 11:57:32 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The device tree for the MPC8641 HPCN does not implement the device type
> property for I8042 nodes.
>
> In addition to checking the I8042 node's device type, also match the
> keyboard and/or mouse nodes' compatible property.
>
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

Looks good.


Segher
