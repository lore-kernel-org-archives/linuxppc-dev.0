Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E686B67A66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 06:52:04 +1100 (EST)
Date: Tue, 18 Jan 2005 09:34:50 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: torvalds@osdl.org, akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0501180925070.11311@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/4] ppc32: platform_device conversion from OCP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Linus,

I would like to try to get these patches into 2.6.11.  They add 
infrastructure for all ppc sub-archs to use platform_devices instead of 
OCP.  Additionally, I've converted the 85xx sub-arch and gianfar enet 
driver (used by 85xx) over to using platform_device and the new 
infrastructure.

The sooner these get in the easier it will be to convert the other 
sub-archs and drivers to platform_device and remove OCP.

- kumar
