Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C6239B7C5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:49:16 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 282DADDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:49:15 +1000 (EST)
Message-Id: <0A998CA2-4E4E-4104-A5F4-235B4B746EAA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818220419.GE25090@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 5/8] spi_mpc8xxx: Fix uninitialized variable
Date: Fri, 28 Aug 2009 00:48:50 -0500
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220419.GE25090@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 5:04 PM, Anton Vorontsov wrote:

> This patch fixes the following warning:
>
> CC      drivers/spi/spi_mpc8xxx.o
>  spi_mpc8xxx.c: In function 'of_mpc8xxx_spi_probe':
>  spi_mpc8xxx.c:681: warning: 'ret' may be used uninitialized in this  
> function
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/spi/spi_mpc8xxx.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
