Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 608F4DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Nov 2008 23:43:12 +1100 (EST)
Received: from [196.46.65.21] (helo=[172.16.63.46])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1Kwylo-0000oD-4x
	for linuxppc-embedded@ozlabs.org; Mon, 03 Nov 2008 14:43:00 +0200
Message-ID: <490EF1D8.5090504@vastech.co.za>
Date: Mon, 03 Nov 2008 14:43:04 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8540 performance counters missing
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I have recently moved from kernel 2.6.19 to 2.6.24 ( both supplied by
DENX) and using the ppc architecture. I have found that the performance
counters that were available in /sys/devises/platform/fsl-perfmon.1 are
missing since switching to the newer kernel.

could someone pls. help with what i am missing
thanks pieter
