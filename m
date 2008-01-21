Return-Path: <MBenedict@twacs.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1871FDDED4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 05:20:28 +1100 (EST)
Received: from outbound3-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-sin-R.bigfish.com (Postfix) with ESMTP id DCC77D05B9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:20:26 +0000 (UTC)
Received: from mail109-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound3-sin.bigfish.com (Postfix) with ESMTP id CE05417C0052
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:20:26 +0000 (UTC)
Received: from mail109-sin (localhost.localdomain [127.0.0.1])
	by mail109-sin-R.bigfish.com (Postfix) with ESMTP id A915AC501F9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:20:26 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail109-sin.bigfish.com (Postfix) with ESMTP id 2186EA40089
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jan 2008 18:20:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Early driver development resources
Date: Mon, 21 Jan 2008 12:20:26 -0600
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2F01@twx-exch01.twacs.local>
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

Hello,
	I wrote a driver for a 4 segment digital display device.  I have
a requirement that this device be used as early as possible to report
kernel bootup state.  The driver itself is pretty simple, just using
in/out_be32() and udelay().  The problem is that I don't know how to use
hardware resources in the early stages of booting, before I can call
request_mem_region() and friends.
	Can anyone recommend a book / documentation / reference code /
anything that demonstrates this, or at least could improve my
understanding enough to accomplish this?
	Many thanks,
		Michael
