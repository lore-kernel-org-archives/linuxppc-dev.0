Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B1A2B2C0419
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 19:49:08 +1100 (EST)
Date: Tue, 20 Nov 2012 09:20:46 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 207/493] i2c: remove use of __devinit
Message-ID: <20121120092046.24496415@endymion.delvare>
In-Reply-To: <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Wolfram Sang <w.sang@pengutronix.de>,
 "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-omap@vger.kernel.org,
 linux-i2c@vger.kernel.org, Ben
 Dooks  <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>,
 Olof Johansson <olof@lixom.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bill,

On Mon, 19 Nov 2012 13:22:36 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Can you please point me/us to the discussion explaining the rationale
behind this move, and the explanation of what will be done exactly?
While I can easily understand that we want to drop CONFIG_HOTPLUG and
always enable hot-plug support, I don't see where we are going with
removing __devinit annotations and the like.

Thanks,
-- 
Jean Delvare
