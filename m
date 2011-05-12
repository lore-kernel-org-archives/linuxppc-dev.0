Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61E28B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 07:58:00 +1000 (EST)
Date: Thu, 12 May 2011 22:57:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: wanlong.gao@gmail.com
Subject: Re: [PATCH] fix build warnings on defconfigs
Message-ID: <20110512215746.GB21865@linux-mips.org>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com, tony@atomide.com,
	nicolas.ferre@atmel.com, paulus@samba.org, eric@eukrea.com,
	sam@ravnborg.org, sfr@canb.auug.org.au, linux@arm.linux.org.uk,
	khilman@deeprootsystems.com, manuel.lauss@googlemail.com,
	u.kleine-koenig@pengutronix.de, mingo@elte.hu,
	rientjes@google.com, anton@samba.org, ben-linux@fluff.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao@gmail.com wrote:

> Subject: [PATCH] fix build warnings on defconfigs
> 
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

I've queued the MIPS bits only for 2.6.40.  Thanks.

  Ralf
