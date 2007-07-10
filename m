Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9270EDE095
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:48:56 +1000 (EST)
Date: Tue, 10 Jul 2007 14:52:56 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
Message-ID: <20070710145256.6ac64e11@localhost.localdomain>
In-Reply-To: <468FC376.2040405@ru.mvista.com>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707094900.9473.48577.stgit@localhost.localdomain>
	<468FC376.2040405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 07 Jul 2007 20:46:46 +0400
Sergei Shtylyov wrote:

> > +
> > +#ifdef CONFIG_MPC834x_ITX  
> 
>     Erm, isn't this stuff misplaced? Is this really SoC device? I
> remember seeng this in the arch/ppc/ platform code before (in the
> internal tree)...

The point is to declare methods bsp, as mmio access may effectively vary (having bugs or intentionally) from platform to platform. All-in-one driver approach is nice but might be an issue to handle/maintain.

Thanks for looking at it, other notes make sense.

-- 
Sincerely, Vitaly
