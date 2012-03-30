Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D018B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 02:25:14 +1100 (EST)
In-Reply-To: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
References: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
Subject: Re: [PATCH] Bug fix in commit 178db7d3 triggered a bug in the SPI
 driver for MPC83XX (pdata is NULL).
To: Kenth Eriksson <kenth.eriksson@transmode.com>
Message-ID: <OF31A01223.1122F8EE-ONC12579D1.0053C57F-C12579D1.0053DE76@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 30 Mar 2012 17:16:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kenth Eriksson <kenth.eriksson@transmode.com> wrote on 2012/03/30 17:05:30:
>
> After commit 178db7d3 devices are initialized as children of the bus master, not children of the bus masters parent device. The pdata pointer used in fsl_spi_chipselect must updated to reflect the changed initialization.
>
> Signed-off-by: Kenth Eriksson <kenth.eriksson@transmode.com>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
