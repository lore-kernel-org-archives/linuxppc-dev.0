Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 20:30:43 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de> <4457A2D6.4070400@am.sony.com>
In-Reply-To: <4457A2D6.4070400@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605022030.44057.arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Tuesday 02 May 2006 20:20 schrieb Geoff Levand:
> Split the Cell BE support into generic and platform dependent parts.
>
> Creates new config variables PPC_CELL_NATIVE and PPC_IBM_CELL_BLADE.
> The existing CONFIG_PPC_CELL is now used to denote the generic
> Cell processor support.
>
> Also renames spu_priv1.c to spu_priv1_mmio.c.

Ok, looks good now.

> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
