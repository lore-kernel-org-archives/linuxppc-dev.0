Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 65C8FDDD05
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 06:36:16 +1100 (EST)
Message-ID: <45F84EA0.2080405@freescale.com>
Date: Wed, 14 Mar 2007 14:36:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a configurable
	option
References: <Pine.LNX.4.64.0703141314400.18994@localhost.localdomain>
	<20070314133738.3139d062.kim.phillips@freescale.com>
In-Reply-To: <20070314133738.3139d062.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips wrote:
> On Wed, 14 Mar 2007 13:15:05 -0500 (CDT)
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
>>  arch/powerpc/Kconfig                |    8 --------
>>  arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
>>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> What about 85xx QE support?

Kumar and I talked about it.  85xx support will be added when QE works on 85xx.  However, 
the patch still needs changes.  To allow each CPU family to have its own QE option, we'll 
need to define something like QUICC_ENGINE_83xx and QUICC_ENGINE_85xx, and then have 
something like this:

config QUICC_ENGINE
	bool
	default y if QUICC_ENGINE_83xx || QUICC_ENGINE_85xx

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
