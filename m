Return-Path: <martyn.welch@ge.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8424CB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 21:22:42 +1100 (EST)
From: Martyn Welch <martyn.welch@ge.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 0/2] powerpc: Add support for GE IMP3A
Date: Tue, 28 Feb 2012 10:22:19 +0000
Message-Id: <1330424541-5299-1-git-send-email-martyn.welch@ge.com>
Cc: Martyn Welch <martyn.welch@ge.com>, Wim Van Sebroeck <wim@iguana.be>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add support for the GE IMP3A. This board (based on a Freescale
P2020) uses some support for FPGA logic common with the PPC9A and other 86xx
based boards, so this support has been moved out of the 86xx directory. A
config option (GE_FPGA) has been added to reduce churn on dependant drivers
(such as the watchdog timer) when further boards are added.
