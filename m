Return-Path: <plagnioj@jcrosoft.com>
Received: from 30.mail-out.ovh.net (30.mail-out.ovh.net [213.186.62.213])
	by ozlabs.org (Postfix) with SMTP id DA42EB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 13:04:01 +1000 (EST)
Date: Mon, 11 Apr 2011 04:45:59 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: wanlong.gao@gmail.com
Subject: Re: [PATCH] fix build warnings on defconfigs
Message-ID: <20110411024559.GB18925@game.jcrosoft.org>
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
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	santosh.shilimkar@ti.com, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03:04 Sun 10 Apr     , wanlong.gao@gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
for at91
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
