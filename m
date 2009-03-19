Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABD72DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 20:01:59 +1100 (EST)
Message-Id: <BAC3F8F8-F506-4493-94A4-5383398A7E08@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090319085404.7336.49994.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v4 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Date: Thu, 19 Mar 2009 04:01:42 -0500
References: <20090319084914.7336.81244.stgit@ubuntu8041.localdomain>
	<20090319085404.7336.49994.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 19, 2009, at 3:54 AM, Martyn Welch wrote:

> Support for the PPC9A VME Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
>
> This is the basic board support for GE Fanuc's PPC9A, a 6U single  
> board
> computer, based on Freescale's MPC8641D.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_ppc9a.dts     |  364 ++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/86xx/Kconfig     |   10 +
> arch/powerpc/platforms/86xx/Makefile    |    1
> arch/powerpc/platforms/86xx/gef_ppc9a.c |  223 +++++++++++++++++++
> drivers/watchdog/Kconfig                |    2
> 5 files changed, 598 insertions(+), 2 deletions(-)

applied to next.  (fixed a trailing whitespace issue in the .dts)

- k
