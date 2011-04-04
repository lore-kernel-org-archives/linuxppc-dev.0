Return-Path: <balbi@ti.com>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78D9BB6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Apr 2011 23:43:12 +1000 (EST)
Received: by mail-ey0-f181.google.com with SMTP id 5so1853981eyh.40
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 06:43:07 -0700 (PDT)
Date: Mon, 4 Apr 2011 16:43:04 +0300
From: Felipe Balbi <balbi@ti.com>
To: tmarri@apm.com
Subject: Re: [PATCH v13 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	Interface Layer (CIL)
Message-ID: <20110404134303.GN2461@legolas.emea.dhcp.ti.com>
References: <1301872613-2825-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301872613-2825-1-git-send-email-tmarri@apm.com>
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

On Sun, Apr 03, 2011 at 04:16:53PM -0700, tmarri@apm.com wrote:
> +const char *op_state_str(enum usb_otg_state state)

please don't introduce yet another version of this. Make the ones
available generic. Place a static inline const char
*otg_state_string(struct otg_transceiver *x) on include/linux/usb/otg.h

> +/**
> + * This function enables the controller's Global Interrupt in the AHB Config
> + * register.
> + */

useless comments :-) or convert to kerneldoc.

-- 
balbi
