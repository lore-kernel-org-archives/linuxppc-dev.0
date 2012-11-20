Return-Path: <davidb@codeaurora.org>
Date: Tue, 20 Nov 2012 08:57:26 -0800
From: David Brown <davidb@codeaurora.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 158/493] video: remove use of __devinit
Message-ID: <20121120165726.GB21706@codeaurora.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
Cc: linux-fbdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Michal Januszewski <spock@gentoo.org>, Paul Mackerras <paulus@samba.org>,
 linux-nvidia@lists.surfsouth.com, Daniel Walker <dwalker@fifo99.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jaya Kumar <jayalk@intworks.biz>, cbe-oss-dev@lists.ozlabs.org,
 Antonino Daplas <adaplas@gmail.com>, linux-arm-msm@vger.kernel.org,
 Thomas Winischhofer <thomas@winischhofer.net>, linux-geode@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Maik Broemme <mbroemme@plusserver.de>, Geoff Levand <geoff@infradead.org>,
 gregkh@linuxfoundation.org, Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xensource.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:21:47PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/video/msm/mddi.c                           |  6 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
