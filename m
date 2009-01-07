Return-Path: <dibacco@libero.it>
Received: from cp-out4.libero.it (cp-out4.libero.it [212.52.84.104])
	by ozlabs.org (Postfix) with ESMTP id D56F9474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:59:38 +1100 (EST)
Received: from libero.it (192.168.17.6) by cp-out4.libero.it (8.5.016.1)
	id 493F94E401F81BAD for linuxppc-dev@ozlabs.org;
	Wed, 7 Jan 2009 21:59:36 +0100
Date: Wed,  7 Jan 2009 21:59:36 +0100
Message-Id: <KD4CZC$63E26AC2C9F30D8D9F146E56F7574045@libero.it>
Subject: __pa giving strange phys address on PPC
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@libero\.it" <dibacco@libero.it>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using a linux 2.6.19 (from Denx ELDK) on a PPC MPC880. In a driver (t=
hat uses TDM channels) I have some calls to __pa to get the physical addr=
ess corresponding to a virtual address. The physical address returned by =
__pa is higher than the maximum physical memory I have on the board. This=
 result make my driver hang. The driver I'm trying to use was written for=
 a 2.4 kernel and I'm wondering if I have to replace the calls to __pa wi=
th some other API/MACRO.

Thank you in advance.
