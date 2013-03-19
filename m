Return-Path: <Sergey.Gerasimov@astrosoft-development.com>
Received: from storage.astrosoft.ru (storage.astrosoft.ru [195.218.158.6])
 by ozlabs.org (Postfix) with SMTP id F12262C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 21:10:07 +1100 (EST)
From: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Mar 2013 14:09:38 +0400
Subject: RE: [PATCH 1/1] Add a new platform tree for ib8315. Also add the
 DTS and the defconfig for that board.
Message-ID: <94EB659E3D5E594D80696B67540292A2F6D13719A1@nov-exch01.astro.local>
References: <1363614452-1109-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
 <307780DE-9735-4329-B5D7-DF2E9451A217@kernel.crashing.org>
In-Reply-To: <307780DE-9735-4329-B5D7-DF2E9451A217@kernel.crashing.org>
Content-Type: text/plain; charset="koi8-r"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes. Ib8315 based on tqm8315. Ib8315 is baseboard that has the tqm8215m plu=
gged in as "the central part".=20

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: 19 =CD=C1=D2=D4=C1 2013 =C7. 00:18
To: Sergey Gerasimov
Cc: Benjamin Herrenschmidt; Paul Mackerras; linuxppc-dev@lists.ozlabs.org; =
linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add a new platform tree for ib8315. Also add the D=
TS and the defconfig for that board.


On Mar 18, 2013, at 8:47 AM, Sergey Gerasimov wrote:

> Signed-off-by: Sergey Gerasimov=20
> <Sergey.Gerasimov@astrosoft-development.com>
> ---
> arch/powerpc/boot/dts/ib8315.dts           |  490 +++++++
> arch/powerpc/configs/83xx/ib8315_defconfig | 2121 +++++++++++++++++++++++=
+++++
> arch/powerpc/platforms/83xx/Kconfig        |    7 +
> arch/powerpc/platforms/83xx/Makefile       |    1 +
> arch/powerpc/platforms/83xx/tqm8315.c      |  137 ++
> 5 files changed, 2756 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/ib8315.dts create mode 100644=20
> arch/powerpc/configs/83xx/ib8315_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/tqm8315.c

Is there some relationship of this board with the TQM8315?

- k
