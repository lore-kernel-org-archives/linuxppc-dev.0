Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AB911A08FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 02:57:13 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC,1/8] soc/fman: Add FMan MURAM support
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1426050469-12507-1-git-send-email-igal.liberman@freescale.com>
Date: Thu, 12 Mar 2015 10:56:55 -0500
Message-Id: <32CF85E2-A8AA-454D-A46F-0E778DAF97ED@kernel.crashing.org>
References: <1426050469-12507-1-git-send-email-igal.liberman@freescale.com>
To: "Igal.Liberman" <igal.liberman@freescale.com>
Cc: scottwood@freescale.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 11, 2015, at 12:07 AM, Igal.Liberman =
<igal.liberman@freescale.com> wrote:

> From: Igal Liberman <Igal.Liberman@freescale.com>
>=20
> Add Frame Manager Multi-User RAM support.
>=20
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
> drivers/soc/fsl/fman/Kconfig            |    1 +
> drivers/soc/fsl/fman/Makefile           |    5 +-
> drivers/soc/fsl/fman/fm_muram.c         |  174 =
+++++++++++++++++++++++++++++++
> drivers/soc/fsl/fman/inc/fm_muram_ext.h |   98 +++++++++++++++++
> 4 files changed, 276 insertions(+), 2 deletions(-)
> create mode 100644 drivers/soc/fsl/fman/fm_muram.c
> create mode 100644 drivers/soc/fsl/fman/inc/fm_muram_ext.h
>=20

use lib/genalloc instead of rheap

- k=
