Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BD1B67A46
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Mar 2005 00:54:21 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16946.62597.739208.125687@astp0002.localdomain>
Date: Sat, 12 Mar 2005 15:54:13 +0200
To: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
In-Reply-To: <BAY1-DAV14F92D2B45266ECD1105A48B540@phx.gbl>
References: <BAY1-DAV14F92D2B45266ECD1105A48B540@phx.gbl>
Cc: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: problem opening I2C device on MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Vijay Padiyar writes:

...

    Vijay> When I try to open the I2C device from a user program in root
    Vijay> mode, I get an error and the value of errno is ENODEV.

...

This means that there is no I2C controller driver in your
kernel. Probably you use stock kernel which does not contain driver for
CPM I2C. You have to look for a custom kernel (I can offer Arabella
Linux) or try to apply one of the patches which were posted in the past.

Best regards,
-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
