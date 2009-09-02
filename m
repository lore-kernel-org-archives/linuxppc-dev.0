Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7A3F7B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 21:35:59 +1000 (EST)
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 13CB5DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 21:35:57 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Mio7p-0000CS-NT
	for linuxppc-dev@ozlabs.org; Wed, 02 Sep 2009 13:35:41 +0200
Received: from p4ff065d6.dip.t-dialin.net ([79.240.101.214])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 13:35:41 +0200
Received: from dzu by p4ff065d6.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 13:35:41 +0200
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: [RFC][POWERPC] WDT: added support for the WDT Chain driver.
Date: Wed, 02 Sep 2009 13:32:23 +0200
Message-ID: <m2d469pooo.fsf@ohwell.denx.de>
References: <20090902004928.132974c9@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Vitaly,

> From: Heiko Schocher <hs@denx.de>
>
> [POWERPC] WDT: added support for the WDT Chain driver.
>
>     This new driver implements a character device with major number 10
>     and minor number 130.  It is a software abstraction of the hardware
>     watchdog with two different APIs.  While the driver periodically
>     triggers the hardware watchdog, the software can setup independent
>     timeout periods.
>
>     More info in Documentation/watchdog/wdt_chain.txt
>
>     Signed-off-by: Heiko Schocher <hs@denx.de>
>     Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> ---
> This code was (and is) originally residing in DENX public git repo. I
> think it would be useful upstream, to prevent reinventing the same
> thing. 

Thanks a lot for taking an interest in this piece of code.  I would
suggest however that you coordinate with Heiko as he has worked some
more on this driver in the meantime.  This new code however is not in
our repository.  We should start the RFC discussion with current code.

For the casual reader this means, don't invest time into reviewing this
but wait for a cleaned up version instead.

Thanks
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
