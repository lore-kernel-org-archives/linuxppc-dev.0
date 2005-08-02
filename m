Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2672067E72
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 23:44:36 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j72DomIY018004
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 Aug 2005 06:50:48 -0700 (MST)
Received: from [192.168.123.101] ([10.214.72.234])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j72DlsO2012077
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 Aug 2005 08:47:54 -0500 (CDT)
Mime-Version: 1.0 (Apple Message framework v733)
Message-Id: <0901C40A-7BC0-4227-BEE2-195478DF0CD0@freescale.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 2 Aug 2005 08:44:39 -0500
Subject: MPC8245/1 UARTs and linux-2.6.13-rc5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For all people have issues with the UARTs on MPC8245/1.  In the  
2.6.13 kernel we reworked the support for UARTs to be platform  
devices.  If you look at the 2.6.13-rc5 release you will see the  
changes that went in.  Additionally, the sandpoint reference platform  
code was updated to take advantage of the changes.

Hopefully, these changes will make some of the issues you might be  
facing less of a problem.

- kumar 
