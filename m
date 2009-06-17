Return-Path: <jal2@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by bilbo.ozlabs.org (Postfix) with SMTP id 05476B71DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 19:56:00 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 17 Jun 2009 11:49:17 +0200
From: "Joerg Albert" <jal2@gmx.de>
Message-ID: <20090617094917.308670@gmx.net>
MIME-Version: 1.0
Subject: 8xx: 2.4.25, fec.c, consistent_alloc and eth_copy_and_sum
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looking into arch/ppc/8xx_io/fec.c in the linuxppc_2_4_devel git tree I wonder if it is necessary to copy every received frame from memory allocated by consistent_alloc into a socket buffer? Couldn't we let the FEC
DMA directly into the socket buffer to improve the performance?

BTW, has someone tried to implement NAPI in this driver?

Regards,
Joerg
-- 
GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und Telefonanschluss
für nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
