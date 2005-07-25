Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F50067CDF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 19:48:34 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17124.46441.807442.139506@astp0002.localdomain>
Date: Mon, 25 Jul 2005 12:48:25 +0300
To: Grant Likely <glikely@gmail.com>
In-Reply-To: <528646bc050723070419b8f914@mail.gmail.com>
References: <528646bc050723070419b8f914@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 0/3] Support for SPI busses and devices
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Grant Likely writes:

    Grant> Request for Comment: Here is a set of patches that adds SPI
    Grant> support to linux.  I'm looking for feedback on these and I'd
    Grant> like to eventually get the SPI infrastructure into mainline

[...deleted...]

SPI is very similar to I2C IMHO. I'm not sure separate infrastructure is
needed. We support SPI on MPC8xx/82xx/85xx using the standard I2C
infrastructure. I only had to add a couple of IOCTLs to control clock
frequency and polarity. Due to such an implementation, lm-sensors work
OK with SPI temperature sensors, for example.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
