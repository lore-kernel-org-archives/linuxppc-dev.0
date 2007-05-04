Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id BA3F1DDFF9
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 10:02:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Fri, 4 May 2007 02:01:56 +0200
References: <20070503235747.29275.37271.stgit@localhost.localdomain>
In-Reply-To: <20070503235747.29275.37271.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705040201.57284.arnd@arndb.de>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 May 2007, Vitaly Bordug wrote:
> Adds support for PowerQuicc on-chip PCMCIA. The driver is implemented as
> of_device, so only arch/powerpc stuff is capable to use it, which now
> implies only mpc885ads reference board.
> 
> To cope with the code that should be hooked inside driver, but is really
> board specific (like set_voltage), global structure mpc8xx_pcmcia_ops
> holds necessary function pointers that are filled in the BSP code.
> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
