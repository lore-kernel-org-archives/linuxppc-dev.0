Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id F21E3DDF23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 04:32:33 +1000 (EST)
Received: from [192.168.0.38] (unknown [192.168.0.38])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id 76C15B8C0B8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 12:32:32 -0600 (MDT)
Subject: Kernel Debug on Virtex4-FX
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 06 Sep 2007 12:32:31 -0600
Message-Id: <1189103551.6185.66.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is it possible to debug the kernel via Xilinx JTAG Platform USB cable?

If so, how?
I can debug through the embedded-config.c and boot loader, but once the
kernel boots, (VM on) I cannot debug anymore.  


Or do I have to use kgdb through serial? 




Rob.
