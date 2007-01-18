Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id C365BDDECC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 05:40:36 +1100 (EST)
Date: Thu, 18 Jan 2007 12:40:31 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Bruce_Leonard@selinc.com
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
Message-Id: <20070118124031.3d5e0079.kim.phillips@freescale.com>
In-Reply-To: <OFEC14CD76.6DC877E0-ON88257267.0063D50C-88257267.0065FB8D@selinc.com>
References: <3D87E705-AB2F-490A-BD26-E9C6CE9E6749@kernel.crashing.org>
	<OFEC14CD76.6DC877E0-ON88257267.0063D50C-88257267.0065FB8D@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 18 Jan 2007 10:33:55 -0800
Bruce_Leonard@selinc.com wrote:

> Per Grant's suggestion I changed it to:
> 'dtc -I dts -O dtb -V 0x10 mpc8349emitx.dts > 8349.blob'
> 
I get a 0 length 8349.blob file using the above.  Have you tried -f?

Kim
