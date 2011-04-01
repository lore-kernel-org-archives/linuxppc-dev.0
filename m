Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id 02830B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 04:35:51 +1100 (EST)
Received: by gyg13 with SMTP id 13so1741970gyg.13
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 10:35:49 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1301336866-1915-1-git-send-email-tmarri@apm.com>
	<3569ce83abe4f1f3ab1699c2beee1f35@mail.gmail.com>
In-Reply-To: <3569ce83abe4f1f3ab1699c2beee1f35@mail.gmail.com>
MIME-Version: 1.0
Date: Fri, 1 Apr 2011 10:35:48 -0700
Message-ID: <712525e420e78daeb3f43bf1ebc53e23@mail.gmail.com>
Subject: RE: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer (CIL)
To: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, Mark Miesfeld <mmiesfeld@apm.com>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +void dwc_otg_core_init(struct core_if *core_if)
> +{
> +	u32 i;
> +	ulong global_reg = core_if->core_global_regs;
> +	struct device_if *dev_if = core_if->dev_if;
> +	u32 ahbcfg = 0;
> +	u32 i2cctl = 0;
> +	u32 gusbcfg;

Tabify the declarations ;
[Marri] When I checked again in my source, I do see the tabs added before
declarations.
