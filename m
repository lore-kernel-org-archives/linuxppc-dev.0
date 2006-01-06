Return-Path: <janvm@mind.be>
Received: from NAT.office.mind.be (NAT.office.mind.be [62.166.230.82])
	by ozlabs.org (Postfix) with ESMTP id 39207689B5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 01:55:14 +1100 (EST)
Received: from dhcp210.intern.mind.be ([10.42.1.210])
	(envelope-sender <janvm@mind.be>)
	by eros.intern.mind.be (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 6 Jan 2006 14:48:32 -0000
From: "Jan Vermeulen (Mind)" <janvm@mind.be>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 06 Jan 2006 15:48:32 +0100
Message-Id: <1136558912.8271.14.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] Big combined patch for ml403 with OCP, ENET.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

This is my first patch.

It is rather big.

It's for the Xilinx Virtex4 based ref board ml403.

Based on the work of Grant Likely, David H. Lynch Jr. and on the code
from Montavista and Xilinx, I made a big patch including everything,
including my own work to port the OCP and Ethernet driver to the
2.6.14.4 kernel.

I started work on the SysACE driver, but this is a bit more work, as it
isn't using the granulary locking for block drivers as can be found in
the 2.6 kernels.

The gzipped patch (~165kB) can be found here:
ftp://ftp.mind.be/Virtex4/linux-2.6-ml403/ml403_core_ocp_enet_sysace.diff.gz

If I have more time in the future, I'll add support for sound, gpio, ...

Best regards,
Jan Vermeulen
