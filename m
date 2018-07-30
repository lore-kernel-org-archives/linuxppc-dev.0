Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f99G24kvzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 16:47:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
In-Reply-To: <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
Date: Mon, 30 Jul 2018 16:47:13 +1000
Message-ID: <87tvohi5ji.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Finn Thain <fthain@telegraphics.com.au> writes:

> Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> switch over to that driver and remove the via-pmu68k driver.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/configs/mac_defconfig   |   2 +-
>  arch/m68k/configs/multi_defconfig |   2 +-
>  arch/m68k/mac/config.c            |   2 +-
>  arch/m68k/mac/misc.c              |  48 +--
>  drivers/macintosh/Kconfig         |  13 +-
>  drivers/macintosh/Makefile        |   1 -
>  drivers/macintosh/adb.c           |   2 +-
>  drivers/macintosh/via-pmu68k.c    | 846 --------------------------------------
>  include/uapi/linux/pmu.h          |   2 +-
>  9 files changed, 14 insertions(+), 904 deletions(-)
>  delete mode 100644 drivers/macintosh/via-pmu68k.c

Geert are you OK with this and the other one that touches arch/m68k ?

cheers
