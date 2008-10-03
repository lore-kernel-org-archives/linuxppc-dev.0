Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29B94DDED8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 15:05:42 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Block device for the ISS simulator
From: Andi Kleen <andi@firstfloor.org>
References: <20081003000904.0A812DDEEE@ozlabs.org>
Date: Fri, 03 Oct 2008 06:44:03 +0200
In-Reply-To: <20081003000904.0A812DDEEE@ozlabs.org> (Benjamin Herrenschmidt's
	message of "Fri, 03 Oct 2008 10:08:42 +1000")
Message-ID: <87tzbunv8s.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> The ISS simulator is a simple powerpc simulator used among other things
> for hardware bringup. It implements a simple memory mapped block device
> interface.

...
>
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/drivers/block/iss_blk.c	2008-09-23 11:12:03.000000000 +1000
> @@ -0,0 +1,365 @@
> +/*
> + * Simple block device for the ISS simulator
> + */

The first paragraph in your description above should be in this comment.

-Andi
