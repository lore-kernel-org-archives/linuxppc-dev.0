Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D9B362BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 09:30:05 +1100 (EST)
Message-ID: <419E73E7.8080703@mvista.com>
Date: Fri, 19 Nov 2004 15:29:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Support for Artesyn Katana cPCI boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds support for the Artesyn Katana 750i, 752i, and 3750.

This patch depends on the Marvell host bridge support patch (mv64x60) 
[and the ev64260 platform support patch because the 2 patches touch the 
same Makefiles and Kconfig file but there are no code dependencies].

Note that the patch itself does not depend on the previously submitted 
MPSC driver but the platform does.  That is, to use the serial ports on 
those boards, the MPSC driver patch is required.

This patch is larger that 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/katana.patch
