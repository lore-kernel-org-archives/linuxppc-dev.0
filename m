Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01A912C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 07:18:28 +1100 (EST)
Subject: Re: [PATCH 1/1] Add a new platform tree for ib8315. Also add the DTS
 and the defconfig for that board.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363614452-1109-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
Date: Mon, 18 Mar 2013 15:18:15 -0500
Message-Id: <307780DE-9735-4329-B5D7-DF2E9451A217@kernel.crashing.org>
References: <1363614452-1109-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
To: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 8:47 AM, Sergey Gerasimov wrote:

> Signed-off-by: Sergey Gerasimov =
<Sergey.Gerasimov@astrosoft-development.com>
> ---
> arch/powerpc/boot/dts/ib8315.dts           |  490 +++++++
> arch/powerpc/configs/83xx/ib8315_defconfig | 2121 =
++++++++++++++++++++++++++++
> arch/powerpc/platforms/83xx/Kconfig        |    7 +
> arch/powerpc/platforms/83xx/Makefile       |    1 +
> arch/powerpc/platforms/83xx/tqm8315.c      |  137 ++
> 5 files changed, 2756 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/ib8315.dts
> create mode 100644 arch/powerpc/configs/83xx/ib8315_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/tqm8315.c

Is there some relationship of this board with the TQM8315?

- k=
