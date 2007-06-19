Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45151DDF4F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 18:49:43 +1000 (EST)
In-Reply-To: <1182237558.3269.14.camel@localhost.localdomain>
References: <1182237558.3269.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b653522c06e6053167988bb8bcf3a868@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2]: Document the global utilities node define and example
Date: Tue, 19 Jun 2007 10:49:18 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Document the global utilities node define and example.
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks for documenting this stuff.  One nit though...

> +	global-utilities@e0000 {	/* global utilities reg */

s/reg/block/ .  It's not a single 32768 bit register I'm
sure (how would you access it?!)  :-)


Segher
