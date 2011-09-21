Return-Path: <davidb@codeaurora.org>
Date: Wed, 21 Sep 2011 13:22:02 -0700
From: David Brown <davidb@codeaurora.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 49/57] video: irq: Remove IRQF_DISABLED
Message-ID: <20110921202202.GB2321@huya.qualcomm.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-50-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316597339-29861-50-git-send-email-yong.zhang0@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>,
	David Brown <davidb@codeaurora.org>,
	Anatolij Gustschin <agust@denx.de>, cbe-oss-dev@lists.ozlabs.org,
	Wan ZongShun <mcuos.com@gmail.com>,
	linux-arm-msm@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	tglx@linutronix.de, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Geoff Levand <geoff@infradead.org>,
	Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
	Bryan Huntsman <bryanh@codeaurora.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2011 at 05:28:50PM +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> ---
>  drivers/video/msm/mddi.c                  |    2 +-
>  drivers/video/msm/mdp.c                   |    2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
