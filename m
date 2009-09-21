Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7101B7B72
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 01:35:43 +1000 (EST)
Received: from bzq-82-81-138-186.red.bezeqint.net ([82.81.138.186]:50086
	helo=felix.lan) by vega.surpasshosting.com with esmtpa (Exim 4.69)
	(envelope-from <felix@embedded-sol.com>) id 1MpkvS-0001do-7r
	for linuxppc-dev@ozlabs.org; Mon, 21 Sep 2009 11:35:38 -0400
Message-ID: <4AB79D41.60902@embedded-sol.com>
Date: Mon, 21 Sep 2009 18:35:29 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Subject: MPC8536 PCI rescan to discover FPGA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On a custom MPC8536 board running linux-2.6.31,
I'd like to load FPGA code from linux and then rescan
PCI-E bus to discover FPGA device. Is that possible ?
When linux boots FPGA is not loaded, so initial PCI
scan does not detect it.

I've tried playing with /sys/bus/pci/rescan and 
/sys/bus/pci/devices/.../rescan
but didn't have much success.

Thanks.

Felix.
