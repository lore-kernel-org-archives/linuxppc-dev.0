Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1643C67A77
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 17:51:20 +1100 (EST)
Date: Tue, 15 Mar 2005 22:50:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-Id: <20050315225050.4a236b3e.akpm@osdl.org>
In-Reply-To: <42376A46.2090605@mvista.com>
References: <42376A46.2090605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.11] ppc32: update Radstone ppc7d platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
>  +ppc7d_fixup_i2c_pdata(struct platform_device *pdev)
>  +{
>  +	struct mv64xxx_i2c_pdata *pdata;
>  +	int i;
>  +
>  +	pdata = pdev->dev.platform_data;
>  +	if (pdata == NULL) {
>  +		pdata = kmalloc(GFP_KERNEL, sizeof(*pdata));

I'll switch those kmalloc args around for you.
