Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30C97DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 02:26:21 +1100 (EST)
Received: from [172.26.6.74] ([172.26.6.74]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	mAJFQ3Se008117
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Nov 2008 16:26:07 +0100
Message-ID: <49243010.9070106@selcomgroup.com>
Date: Wed, 19 Nov 2008 16:26:08 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC512x SPI very high cpu load
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
we're using the latest denx tree on an mpc512x, and we have a 
touchscreen on the spi which is talking at 100kHz.

The polling frequency is 5ms and we transmit around 20 bytes per poll.

If we keep the touchscreen pressed, cpu utilization goes to 70% for the 
spi task. This is quite strange, since I thought the mpc512x would be 
using DMA to feed the PSC FIFOs.

Has anyone found the same problem? Should I lower the spi bandwidth?

Thank you,
Matteo
