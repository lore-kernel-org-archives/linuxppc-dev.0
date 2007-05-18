Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-105-friday.noc.nerim.net [62.4.17.105])
	by ozlabs.org (Postfix) with ESMTP id 3DCD1DDEE4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 01:26:54 +1000 (EST)
Date: Fri, 18 May 2007 17:27:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070518172711.2db7fc92@hyperion.delvare>
In-Reply-To: <464CADBB.9050500@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<8183195dad79296e3986f561bf929067@kernel.crashing.org>
	<464CADBB.9050500@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
> (and the 
> i2c code in Linux should be fixed to allow drivers to specify multiple 
> match names).

Back when David proposed his new-style i2c code, I had the same
objection. But we addressed the need differently. If you look at struct
i2c_board_info, you'll see two string fields, driver_name and type. The
former specifies the driver name, the second specifies the exact device
variant. For drivers which support several device variants, the
platform code should fill both fields.

-- 
Jean Delvare
