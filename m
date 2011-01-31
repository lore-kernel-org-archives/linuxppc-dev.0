Return-Path: <sameo@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id B2C13B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Jan 2011 22:00:37 +1100 (EST)
Date: Mon, 31 Jan 2011 11:50:31 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/4 v4] video, sm501: add I/O functions for use on powerpc
Message-ID: <20110131105030.GD5954@sortiz-mobl>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295863040-11086-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295863040-11086-1-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko,

On Mon, Jan 24, 2011 at 10:57:20AM +0100, Heiko Schocher wrote:
> - add read/write functions for using this driver
>   also on powerpc plattforms
Not sure whose tree this is going through. Probably Paul's one though.
The mfd part looks fine to me, please add my:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
