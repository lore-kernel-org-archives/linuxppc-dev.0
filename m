Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5D17DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 08:33:44 +1100 (EST)
Date: Fri, 29 Feb 2008 16:34:09 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Sequoia build with KDBG 
In-Reply-To: <20080222145224.7349cf36@weaponx>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080229213344.E5D17DDE0F@ozlabs.org>
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

I attempted to enable the kernel debugger on my Sequoia board, and I 
get build errors:
  /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:254: undefined 
reference to `set_debug_traps'
  /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:259: undefined 
reference to `breakpoint'

Josh: I assume you have used the kernel debugger with your 44x 
boards, how did you build it?

thanks so much,
Steve
