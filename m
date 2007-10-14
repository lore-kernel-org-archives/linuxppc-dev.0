Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id AFEFCDDE0F
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 17:55:25 +1000 (EST)
Date: Sun, 14 Oct 2007 09:55:11 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: galak@kernel.crashing.org, jgarzik@pobox.com
Subject: [PATCH v3 0/4] FEC - fast ethernet controller for mpc52xx
Message-ID: <20071014075511.GC3000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!

If there are no objections, I would like to get this merged
when bestcomm goes in (any time now?).

It's split into four parts:
1 - device tree
2 - small bestcomm change
3 - the actual driver
4 - phy part of the driver


	Domen

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
