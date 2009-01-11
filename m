Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6E2DDDFBA
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 04:31:07 +1100 (EST)
Date: Sun, 11 Jan 2009 18:10:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
	drivers/i2c/chips/
Message-ID: <20090111181055.31611474@hyperion.delvare>
In-Reply-To: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

On Sun, 11 Jan 2009 19:51:36 +0300, Anton Vorontsov wrote:
> This patch is used to help Jean Delvare to get rid of drivers/i2c/chips/
> directory. The new location suggested by Kumar Gala: as the driver is
> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks for doing this. Do you expect me to take this patch in my i2c
tree, or will it go in some powerpc tree?

-- 
Jean Delvare
