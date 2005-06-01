Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id AF52B679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 04:08:41 +1000 (EST)
Date: Wed, 1 Jun 2005 11:08:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: torvalds@osdl.org, akpm@osdl.org
Message-ID: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][1/3] RapidIO support: core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adds a RapidIO subsystem to the kernel. RIO is a switched
fabric interconnect used in higher-end embedded applications.
The curious can look at the specs over at http://www.rapidio.org

The core code implements enumeration/discovery, management of
devices/resources, and interfaces for RIO drivers.

There's a lot more to do to take advantages of all the hardware
features. However, this should provide a good base for folks
with RIO hardware to start contributing.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Patch is 108KB and can be found here:
ftp://source.mvista.com/pub/rio/l26_rio_core.patch

-Matt
