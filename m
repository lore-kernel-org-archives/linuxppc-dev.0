Return-Path: <jchapman@katalix.com>
Received: from ptb-relay02.plus.net (ptb-relay02.plus.net [212.159.14.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FB1367A87
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 20:46:55 +1100 (EST)
Message-ID: <42380075.1070206@katalix.com>
Date: Wed, 16 Mar 2005 09:46:29 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
References: <42376A46.2090605@mvista.com>
	<20050315225050.4a236b3e.akpm@osdl.org>
In-Reply-To: <20050315225050.4a236b3e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Andrew Morton wrote:

> "Mark A. Greer" <mgreer@mvista.com> wrote:
> 
>> +ppc7d_fixup_i2c_pdata(struct platform_device *pdev)
>> +{
>> +	struct mv64xxx_i2c_pdata *pdata;
>> +	int i;
>> +
>> +	pdata = pdev->dev.platform_data;
>> +	if (pdata == NULL) {
>> +		pdata = kmalloc(GFP_KERNEL, sizeof(*pdata));
> 
> 
> I'll switch those kmalloc args around for you.

Wow, I'm surprised it ever worked! Thanks!
