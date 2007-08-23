Return-Path: <MBenedict@twacs.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CA08BDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 06:03:25 +1000 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id A39AE4415C6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 20:03:23 +0000 (UTC)
Received: from mail143-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id 967C913D8082
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 20:03:23 +0000 (UTC)
Received: from mail143-sin (localhost.localdomain [127.0.0.1])
	by mail143-sin-R.bigfish.com (Postfix) with ESMTP id 8A5D95904D1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 20:03:23 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail143-sin.bigfish.com (Postfix) with ESMTP id A7F6C120068
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 20:03:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: powersave-nap
Date: Thu, 23 Aug 2007 15:03:04 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2B3A@twx-exch01.twacs.local>
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

I was curious what the common setting was for
/proc/sysctl/kernel/powersave-nap.

For what its worth, we are running an MPC8347 and we are not counting on
powersaving for our power or heat budget.  We are not running off of
batteries and are much more concerned about responsiveness over power
saving.

>From what I have read, it seems that both nap and doze require "a couple
instructions" to wake up.  If the responsiveness is the same, is there
any reason to use doze?  Why is doze the default?
	Thank you,
		Michael
