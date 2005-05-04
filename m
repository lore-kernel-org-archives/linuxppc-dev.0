Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F130F679F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 09:13:08 +1000 (EST)
In-Reply-To: <4278DDAF.6010605@ru.mvista.com>
References: <4278DDAF.6010605@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a82c91599367bc3ffad39b98969078cd@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 4 May 2005 19:08:45 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2 2/3] FCC Ethernet PlatformDevice support
	for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 10:35 AM, Vitaly Bordug wrote:

> This patch adds some helper functions to the common CPM2 code in order 
> to prevent
> direct *immr usage within network driver.

No, please don't do this.
We don't need "helper" functions for the IO port in this manner.
I've got a new scheme that's been discussed, I just need a few
more "free" hours to finish it.  Suffer with the current situation
for a little longer, we'll get this fixed the right way shortly.

Thanks.


	-- Dan
