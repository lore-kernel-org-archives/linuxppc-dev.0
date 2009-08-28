Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21E27B7DF9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:46:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59E72DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:46:01 +1000 (EST)
Message-Id: <C37BD1BB-7F53-4CC7-ABB0-BBBDDAC5C052@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818220410.GA25090@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/8] powerpc/cpm: Remove SPI defines and spi structs
Date: Fri, 28 Aug 2009 00:45:34 -0500
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220410.GA25090@oksana.dev.rtsoft.ru>
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

> When cpm2.h included into spi_mpc8xxx driver, the SPI defines
> in the header conflict with defines in the driver.
>
> We don't need them in the header file, so remove them. Plus
> remove "struct spi", we'll use a better version in the driver.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/cpm1.h |   45  
> ---------------------------------------
> arch/powerpc/include/asm/cpm2.h |   39  
> ---------------------------------
> 2 files changed, 0 insertions(+), 84 deletions(-)

applied to next

- k
