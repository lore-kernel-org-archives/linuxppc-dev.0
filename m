Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BDBDB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 05:57:47 +1100 (EST)
Received: by wyg36 with SMTP id 36so3454637wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 11:57:42 -0700 (PDT)
Message-ID: <4D961FBA.8090107@ru.mvista.com>
Date: Fri, 01 Apr 2011 22:55:54 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH v10 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer (CIL)
References: <1301336866-1915-1-git-send-email-tmarri@apm.com>
	<3569ce83abe4f1f3ab1699c2beee1f35@mail.gmail.com>
	<712525e420e78daeb3f43bf1ebc53e23@mail.gmail.com>
In-Reply-To: <712525e420e78daeb3f43bf1ebc53e23@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: greg@kroah.com, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>,
	Keshava Munegowda <keshava_mgowda@ti.com>,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Tirumala Marri wrote:

>>> +void dwc_otg_core_init(struct core_if *core_if)
>>> +{
>>> +	u32 i;
>>> +	ulong global_reg = core_if->core_global_regs;
>>> +	struct device_if *dev_if = core_if->dev_if;
>>> +	u32 ahbcfg = 0;
>>> +	u32 i2cctl = 0;
>>> +	u32 gusbcfg;

>> Tabify the declarations ;

> [Marri] When I checked again in my source, I do see the tabs added before
> declarations.

    He means that tabs should be between the variable's type and name, but 
there's no such requirement actually.

WBR, Sergei
