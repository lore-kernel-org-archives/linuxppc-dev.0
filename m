Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E866DDEF1
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 09:28:19 +1000 (EST)
Date: Sun, 6 May 2007 03:27:47 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070506032747.07171caf@localhost.localdomain>
In-Reply-To: <20070504123543.5e3fd908.akpm@linux-foundation.org>
References: <20070503235747.29275.37271.stgit@localhost.localdomain>
	<20070504123543.5e3fd908.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 4 May 2007 12:35:43 -0700
Andrew Morton wrote:

> On Fri, 04 May 2007 03:57:51 +0400
> Vitaly Bordug <vitb@kernel.crashing.org> wrote:
> 
> > 
> > Adds support for PowerQuicc on-chip PCMCIA. The driver is
> > implemented as of_device, so only arch/powerpc stuff is capable to
> > use it, which now implies only mpc885ads reference board.
> > 
> > To cope with the code that should be hooked inside driver, but is
> > really board specific (like set_voltage), global structure
> > mpc8xx_pcmcia_ops holds necessary function pointers that are filled
> > in the BSP code.
> > 
> 
> argh.
> 
> akpm:/home/akpm> grep '^.*        ' x | wc -l 
> 72
> 
> please, Linux uses hard-tabs, not
> spacespacespacespacespacespacespacespace everywhere.
>

Whoops. That must've survived being copypasted from the original m8xx_pcmcia.c.
That reminds me to do Lindent on the affected sources but that is subject for another patch.
Sorry for the hassle. 

Apparently all the issues were correct, and I'll follow-up with the reworked patch. Thanks for looking at it.

-- 
Sincerely, Vitaly
