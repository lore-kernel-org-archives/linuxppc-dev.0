Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id EE2D3DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 22:34:48 +1100 (EST)
Message-ID: <490AEEBF.9000707@scram.de>
Date: Fri, 31 Oct 2008 12:40:47 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Mike Ditto <mditto@consentry.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
References: <490A84F8.20403@consentry.com>
In-Reply-To: <490A84F8.20403@consentry.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mike,

> This patch adds the ability to enable the digital filter in the device
> tree (with the "clock-filter" boolean property) and automates the
> predivider selection according to the clock-frequency and clock-filter
> properties.

looks good.

David, is "clock-filter" an appropriate dts property for this purpose or
would you prefer a different name?

What needs to be done though is to document this change in
Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt.

Thanks,
Jochen
