Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EA0D468802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 15:15:17 +1100 (EST)
Date: Wed, 14 Dec 2005 20:14:30 -0800
To: Kristian Mueller <Kristian-M@Kristian-M.de>
Message-ID: <20051215041430.GB7468@pb15.lixom.net>
References: <1134618322.4972.10.camel@pismo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134618322.4972.10.camel@pismo>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] via-mpu: compile without Power Management support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 15, 2005 at 11:45:22AM +0800, Kristian Mueller wrote:
> Don't check for sleep_in_progress if there is no 
> Power Management support.

Creeping #ifdeffing, not good.

Please move the sleep_in_progress variable outside of #ifdef where it's
defined instead, it will default to 0 and never trigger, but things will
still build.


-Olof
