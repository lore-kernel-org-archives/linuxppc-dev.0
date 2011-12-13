Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08E4F1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 21:17:47 +1100 (EST)
Date: Tue, 13 Dec 2011 11:17:31 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 01/19] mxc_udc: add workaround for ENGcm09152 for i.MX25
Message-ID: <20111213101731.GI27267@pengutronix.de>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
 "open list:FREESCALE USB PER..." <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 "open list:FREESCALE USB PER..." <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Eric,

To make the handling of your patches easier, please

- send a cover letter for multiple patches
- separate them at least by fixes and features
- if possible, do not send patches aimed at multiple
  maintainers in a single series.

I picked every patch looking like a fix for now myself,
but please remember next time. I'll have a look at the non-fix
patches later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
