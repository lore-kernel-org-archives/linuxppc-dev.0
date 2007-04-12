Return-Path: <MBenedict@twacs.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 001D3DDFEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 02:07:21 +1000 (EST)
Received: from outbound2-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-sin-R.bigfish.com (Postfix) with ESMTP id 788B913F90F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 16:07:17 +0000 (UTC)
Received: from mail26-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound2-sin.bigfish.com (Postfix) with ESMTP id 67BBA52805E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 16:07:17 +0000 (UTC)
Received: from mail26-sin (localhost.localdomain [127.0.0.1])
	by mail26-sin-R.bigfish.com (Postfix) with ESMTP id 19AE3E70189
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 16:07:17 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail26-sin.bigfish.com (Postfix) with ESMTP id 3F4BED0007B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 16:07:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Still trying to get a stable 2.6.20.4 running on 8349ITX evalboard
Date: Thu, 12 Apr 2007 11:06:55 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795E3@twx-exch01.twacs.local>
In-Reply-To: <20070412193658.06a958be@vitb.ru.mvista.com>
References: <OFA3732C99.56D7C409-ON882572BA.00702C6D-882572BA.00724020@selinc.com>
	<20070412193658.06a958be@vitb.ru.mvista.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
>Your problem looks very much like odd DDR or memctl=20
>misconfiguration early in u-boot.
>Please try upgrading your firmware with the latest u-boot from=20
>git tree at denx.de. Kernel from Paul Mackerras (powerpc.git)=20
>is also a good thing to give a try.
>
I can verify this bug exists with the latest Denx git u-boot.  Thank
you, I will try Paul Mackerras kernel.

>Also, there is Vitesse switch on this target, which should be=20
>initialized(Normally with vendor-shipped image you'll figure=20
>out how by print thirdp_init. Starting kernel without that may=20
>result in some instability too.
>

I have to admit, this is over my head.  What do you mean by "print
thirdp_init"? =20

Thank you Vitaly!
	-Michael
