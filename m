Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id B2A7CDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 22:28:19 +1100 (EST)
Message-ID: <4912D4B1.7020503@scram.de>
Date: Thu, 06 Nov 2008 12:27:45 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Mike Ditto <mditto@consentry.com>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
References: <49124EAD.8090508@consentry.com>
In-Reply-To: <49124EAD.8090508@consentry.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Ditto schrieb:
> This patch adds the ability to enable the digital filter in the device
> tree (with the "clock-filter" boolean property) and automates the
> predivider selection according to the clock-frequency and clock-filter
> properties.  This allows use of a wider range of I2C bus frequencies.
> 
> Signed-off-by:  Mike Ditto <mditto@consentry.com>

Acked-by: Jochen Friedrich <jochen@scram.de>
