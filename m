Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D904DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Oct 2008 20:03:12 +1100 (EST)
Received: from bzq-79-178-117-167.red.bezeqint.net ([79.178.117.167]:50816
	helo=felix.lan) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1Ktf34-0004IK-Vr
	for linuxppc-embedded@ozlabs.org; Sat, 25 Oct 2008 05:03:07 -0400
Message-ID: <4902E0B5.7060007@embedded-sol.com>
Date: Sat, 25 Oct 2008 11:02:45 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: I2C mux and device tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I run linux-2.6.26 on custom 460EX based board.
This platform has PCA9548 I2C mux on I2C bus 0.
I was wondering how can I describe the mux itself
and devices behind it (e.g RTC and temperature sensors)
in the device tree.

If this is impossible at the moment, what other means
exist to work with devices behind the mux ? I have
found the pca954x patch and related virtual i2c patch
and was able to integrate them intro my kernel. The
question is - how do I tell the kernel to search for RTC
at specific virtual bus and address ? Can I use platform
data for this purpose ?

Thanks a lot.

Felix.
 
