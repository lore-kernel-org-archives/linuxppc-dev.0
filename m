Return-Path: <balbi@ti.com>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59713B6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 00:03:52 +1000 (EST)
Received: by eyg5 with SMTP id 5so2029127eyg.24
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 07:03:45 -0700 (PDT)
Date: Mon, 4 Apr 2011 16:58:29 +0300
From: Felipe Balbi <balbi@ti.com>
To: tmarri@apm.com
Subject: Re: [PATCH v13 08/10] USB ppc4xx: Add Synopsys DWC OTG PCD
	interrupt function
Message-ID: <20110404135827.GP2461@legolas.emea.dhcp.ti.com>
References: <1301872633-3021-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301872633-3021-1-git-send-email-tmarri@apm.com>
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

On Sun, Apr 03, 2011 at 04:17:13PM -0700, tmarri@apm.com wrote:
> +void start_next_request(struct pcd_ep *ep)

this will probably cause namespace clashes at some point. prepent with
dwc_ or make it static.

-- 
balbi
