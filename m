Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 5D6CE2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 08:43:37 +1100 (EST)
Message-ID: <419E6900.5070001@mvista.com>
Date: Fri, 19 Nov 2004 14:43:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Marvell host bridge support (mv64x60)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds core support for a line of host bridges from Marvell 
(formerly Galileo).  This code has been tested with a GT64260a, 
GT64260b, MV64360, and MV64460.  Patches for platforms that use these 
bridges will be sent separately.

The patch is rather large so a link is provided.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/mv64x60.patch
