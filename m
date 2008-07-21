Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5064BDDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 01:24:36 +1000 (EST)
Date: Mon, 21 Jul 2008 10:26:35 -0500
From: Olof Johansson <olof@lixom.net>
To: Marvin <marvin24@gmx.de>
Subject: Re: [1/5] add tune options to Kconfig.cputypes
Message-ID: <20080721152635.GA22613@lixom.net>
References: <200807201927.24198.marvin24@gmx.de>
	<200807201948.24762.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807201948.24762.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Sun, Jul 20, 2008 at 07:48:24PM +0200, Marvin wrote:

> +	  RS64 -> POWER3 -> POWER4 -> POWER5 -> POWER6
> +	                    970/G5
> +	                    CELL BE
> +	                    PA6T
> +	  
> +	  If the compiler/binutils combination does not support the exclusive
> +	  optimization, it will try to tune only or fail.

PA6T implements 2.04 and a few pieces of 2.05, so it sits between
POWER5+ and POWER6 feature-wise.


-Olof
