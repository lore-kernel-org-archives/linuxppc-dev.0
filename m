Return-Path: <keshava_mgowda@ti.com>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F1F4B6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 17:08:24 +1000 (EST)
Received: by mail-bw0-f43.google.com with SMTP id 14so101371bwz.30
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Apr 2011 00:08:20 -0700 (PDT)
From: Keshava Munegowda <keshava_mgowda@ti.com>
References: <1301336866-1915-1-git-send-email-tmarri@apm.com>
	<3569ce83abe4f1f3ab1699c2beee1f35@mail.gmail.com>
	<712525e420e78daeb3f43bf1ebc53e23@mail.gmail.com>
	<4D961FBA.8090107@ru.mvista.com>
MIME-Version: 1.0
In-Reply-To: <4D961FBA.8090107@ru.mvista.com>
Date: Tue, 5 Apr 2011 12:38:03 +0530
Message-ID: <b284084fc5fc0d15e13cbfaf926ee1ce@mail.gmail.com>
Subject: RE: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer (CIL)
To: Sergei Shtylyov <sshtylyov@mvista.com>, Tirumala Marri <tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Saturday, April 02, 2011 12:26 AM
> To: Tirumala Marri
> Cc: Keshava Munegowda; linux-usb@vger.kernel.org;
linuxppc-dev@lists.ozlabs.org; greg@kroah.com;
> Fushen Chen; Mark Miesfeld
> Subject: Re: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
Interface Layer (CIL)
>
> Hello.
>
> Tirumala Marri wrote:
>
> >>> +void dwc_otg_core_init(struct core_if *core_if)
> >>> +{
> >>> +	u32 i;
> >>> +	ulong global_reg = core_if->core_global_regs;
> >>> +	struct device_if *dev_if = core_if->dev_if;
> >>> +	u32 ahbcfg = 0;
> >>> +	u32 i2cctl = 0;
> >>> +	u32 gusbcfg;
>
> >> Tabify the declarations ;
>
> > [Marri] When I checked again in my source, I do see the tabs added
before
> > declarations.
>
>     He means that tabs should be between the variable's type and name,
but
> there's no such requirement actually.

I am sorry if there is no such requirement, since I had such comments and
I fixed it and
Now I have commented.

Keshava Munegowda
