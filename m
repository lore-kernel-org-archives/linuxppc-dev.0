Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C040B7BA5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:47:28 +1100 (EST)
Subject: Re: [PATCH 5/8] spi_mpc8xxx: Fix uninitialized variable
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012164922.GE4578@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:47:15 -0600
Message-Id: <F45D2413-4BA5-4127-A65E-CBF54956576A@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164922.GE4578@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
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


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

> This patch fixes the following warning:
>
> CC      drivers/spi/spi_mpc8xxx.o
>  spi_mpc8xxx.c: In function 'of_mpc8xxx_spi_probe':
>  spi_mpc8xxx.c:681: warning: 'ret' may be used uninitialized in this  
> function
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> drivers/spi/spi_mpc8xxx.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to next

- k
