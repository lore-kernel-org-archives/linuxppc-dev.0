Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB995DDF0C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 01:40:03 +1000 (EST)
Message-Id: <C8A812D2-0B23-4C5E-BA0F-0AD2BB295CF8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080512123533.GA29838@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 86xx: mpc8610_hpcd: fix second serial port
Date: Mon, 12 May 2008 10:39:55 -0500
References: <20080512123533.GA29838@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 12, 2008, at 7:35 AM, Anton Vorontsov wrote:

> DIU platform code should not just write to the PIXIS' BRDCFG0  
> register,
> it should set and clear its own bits only, otherwise it will break
> firmware setup (in fact it breaks second uart).
>
> Also get rid of magic numbers in the related code.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   14 ++++++++++++--
> 1 files changed, 12 insertions(+), 2 deletions(-)

applied.

- k
