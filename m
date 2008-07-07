Return-Path: <dmitry.torokhov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 4D542DDF85
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:20:10 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so1378738wag.13
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 11:20:08 -0700 (PDT)
Date: Mon, 7 Jul 2008 14:19:59 -0400
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080707141843.ZZRA012@mailhub.coreip.homeip.net>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
Cc: Sadanand <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 08:38:45AM -0700, John Linn wrote:
> Added a new driver for Xilinx XPS PS2 IP. This driver is
> a flat driver to better match the Linux driver pattern.
> 
> Signed-off-by: Sadanand <sadanan@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good and I am ready to apply with the exception that compile
errors out when i try to build on x86 (asm/prom.h is missing). Do we
need some Kconfig dependencies added?

-- 
Dmitry
