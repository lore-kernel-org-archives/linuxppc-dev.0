Return-Path: <balbi@ti.com>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33DC5B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Apr 2011 23:54:17 +1000 (EST)
Received: by ewy28 with SMTP id 28so2181234ewy.11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 06:54:12 -0700 (PDT)
Date: Mon, 4 Apr 2011 16:54:10 +0300
From: Felipe Balbi <balbi@ti.com>
To: tmarri@apm.com
Subject: Re: [PATCH v13 07/10] USB/ppc4xx: Add Synopsys DWC OTG PCD function
Message-ID: <20110404135408.GO2461@legolas.emea.dhcp.ti.com>
References: <1301872630-2980-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301872630-2980-1-git-send-email-tmarri@apm.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sun, Apr 03, 2011 at 04:17:10PM -0700, tmarri@apm.com wrote:
> +static const struct usb_gadget_ops dwc_otg_pcd_ops = {
> +	.get_frame = dwc_otg_pcd_get_frame,
> +	.wakeup = dwc_otg_pcd_wakeup,
> +	/* not selfpowered */

will you really have a board running this top operating system which is
Bus powered ? Unless you're forcing all your boards to come with USB
charging I guess you should implement set_selfpowered.


-- 
balbi
