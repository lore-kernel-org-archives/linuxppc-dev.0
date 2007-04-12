Return-Path: <MBenedict@twacs.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 85A9EDDF94
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 05:28:01 +1000 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id 55896903BF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 19:27:57 +0000 (UTC)
Received: from mail46-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id 306CD280063
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 19:27:57 +0000 (UTC)
Received: from mail46-sin (localhost.localdomain [127.0.0.1])
	by mail46-sin-R.bigfish.com (Postfix) with ESMTP id 7D01BCC80EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 19:27:56 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail46-sin.bigfish.com (Postfix) with ESMTP id 90994174805A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 19:27:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Still trying to get a stable 2.6.20.4 running on 8349ITX evalboard
Date: Thu, 12 Apr 2007 14:27:35 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795E6@twx-exch01.twacs.local>
In-Reply-To: <20070412193658.06a958be@vitb.ru.mvista.com>
References: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
	<20070412193658.06a958be@vitb.ru.mvista.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	<Bruce_Leonard@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Your problem looks very much like odd DDR or memctl=20
>misconfiguration early in u-boot.
>Please try upgrading your firmware with the latest u-boot from=20
>git tree at denx.de. Kernel from Paul Mackerras (powerpc.git)=20
>is also a good thing to give a try.

This is definetly something related to u-boot.  I was using a new Denx
git u-boot for flat device tree support.  If I boot a kernel with
hardcoded ethernet-phy registers on the shipping u-boot the system is
much more stable.  Now I am trying to track down the differences between
the u-boot the freescale shipped on the device verse the newest git
sources.  Hopefully some initialization is missing that will be very
obvious.
	Cheers,
		Michael
