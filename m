Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4BD58DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 05:51:33 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@monstr.eu
Subject: Re: [PATCH 04/57] microblaze_v7: Open firmware files
Date: Mon, 23 Mar 2009 19:51:23 +0100
References: <1237408284-8674-1-git-send-email-monstr@monstr.eu>
	<4b5aee01d11fc790c7842838ea63a82ee3273003.1237407249.git.monstr@monstr.eu>
	<af309ba8e95f503b7990461384d9f8453f45dbbd.1237407249.git.monstr@monstr.eu>
In-Reply-To: <af309ba8e95f503b7990461384d9f8453f45dbbd.1237407249.git.monstr@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903231951.23902.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 March 2009, monstr@monstr.eu wrote:
> From: Michal Simek <monstr@monstr.eu>
>=20
>=20
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
> =A0arch/microblaze/include/asm/of_device.h =A0 | =A0 45 ++
> =A0arch/microblaze/include/asm/of_platform.h | =A0 64 ++
> =A0arch/microblaze/include/asm/prom.h =A0 =A0 =A0 =A0| =A0313 ++++++++
> =A0arch/microblaze/kernel/of_device.c =A0 =A0 =A0 =A0| =A0115 +++
> =A0arch/microblaze/kernel/of_platform.c =A0 =A0 =A0| =A0201 +++++
> =A0arch/microblaze/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 | 1147 +++++++++=
++++++++++++++++++++
> =A0arch/microblaze/kernel/prom_parse.c =A0 =A0 =A0 | 1025 +++++++++++++++=
+++++++++++
> =A07 files changed, 2910 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/microblaze/include/asm/of_device.h
> =A0create mode 100644 arch/microblaze/include/asm/of_platform.h
> =A0create mode 100644 arch/microblaze/include/asm/prom.h
> =A0create mode 100644 arch/microblaze/kernel/of_device.c
> =A0create mode 100644 arch/microblaze/kernel/of_platform.c
> =A0create mode 100644 arch/microblaze/kernel/prom.c
> =A0create mode 100644 arch/microblaze/kernel/prom_parse.c

Since these files are derived from the powerpc versions, what is the
plan on them? IIRC, you had them in a common directory in an earlier
version. Are you planning to merge them at some point in the future
or do you intend to maintain a fork?

	Arnd <><
