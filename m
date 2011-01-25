Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id 2C5A21007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 18:51:14 +1100 (EST)
Date: Tue, 25 Jan 2011 16:51:04 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/4 v4] video, sm501: add edid and commandline support
Message-ID: <20110125075104.GJ11673@linux-sh.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295863047-11131-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295863047-11131-1-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 24, 2011 at 10:57:27AM +0100, Heiko Schocher wrote:
> @@ -1884,7 +1935,6 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>  
>  	if (info->pdata == NULL) {
>  		dev_info(dev, "using default configuration data\n");
> -		info->pdata = &sm501fb_def_pdata;
>  	}
>  
>  	/* probe for the presence of each panel */

I assume this is accidental? I don't see how you're compensating for this
in any of the other patches at least, as it's orthogonal from the default
mode settings.
