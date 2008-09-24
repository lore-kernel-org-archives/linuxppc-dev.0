Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 685FFDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:07:20 +1000 (EST)
Message-Id: <B8BAAB1F-10B5-419D-84A7-F724A7E77F41@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080924000336.GB29733@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a dedicated
	function
Date: Tue, 23 Sep 2008 23:07:00 -0500
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<20080924000336.GB29733@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 7:03 PM, Anton Vorontsov wrote:

> qe_gpio_set_dedicated() is a platform specific function, which is used
> to revert a pin to a dedicated function. Caller should have already
> obtained the gpio via gpio_request().
>
> This is needed to support Freescale USB Host Controller.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/qe.h     |    1 +
> arch/powerpc/sysdev/qe_lib/gpio.c |   46 ++++++++++++++++++++++++++++ 
> +++++++++
> 2 files changed, 47 insertions(+), 0 deletions(-)

what do you mean by dedicated function.. be a bit clearer in the  
commit log.  Also, does this depend on gpio_to_chip() patch?

- k
