Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 9FFF42BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 08:49:09 +1100 (EST)
Message-ID: <419E6A50.5060107@mvista.com>
Date: Fri, 19 Nov 2004 14:49:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Support for Marvell EV-64260[ab]-BP eval platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds support for a line of evaluation platforms from Marvell 
that use the Marvell GT64260[ab] host bridges.

This patch depends on the Marvell host bridge support patch (mv64x60).

This patch is larger than 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/ev64260.patch
