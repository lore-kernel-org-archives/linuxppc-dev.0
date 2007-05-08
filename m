Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B4711DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 16:00:24 +1000 (EST)
Date: Tue, 8 May 2007 01:02:26 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070508060226.GB14619@lixom.net>
References: <20070508053049.18428.50622.stgit@localhost.localdomain>
	<20070508054840.18428.28313.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508054840.18428.28313.stgit@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 09:48:44AM +0400, Vitaly Bordug wrote:
> 
> Adds support for PowerQuicc on-chip PCMCIA. The driver is implemented as
> of_device, so only arch/powerpc stuff is capable to use it, which now
> implies only mpc885ads reference board.
> 
> To cope with the code that should be hooked inside driver, but is really
> board specific (like set_voltage), global structure mpc8xx_pcmcia_ops
> holds necessary function pointers that are filled in the BSP code.
> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Olof Johansson <olof@lixom.net>

(Hm, just acked the previous post it seems. :)
