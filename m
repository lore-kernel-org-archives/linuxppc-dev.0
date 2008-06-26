Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 82950DEB33
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:19:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 33/60] microblaze_v4: includes SHM*, msgbuf
Date: Thu, 26 Jun 2008 17:18:17 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-33-git-send-email-monstr@seznam.cz>
	<1214483429-32360-34-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-34-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261718.18006.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> =A0include/asm-microblaze/msgbuf.h =A0 | =A0 39 +++++++++++++++++++++++++=
+++
> =A0include/asm-microblaze/shmbuf.h =A0 | =A0 50 +++++++++++++++++++++++++=
++++++++++++
> =A0include/asm-microblaze/shmparam.h | =A0 14 ++++++++++
> =A03 files changed, 103 insertions(+), 0 deletions(-)
> =A0create mode 100644 include/asm-microblaze/msgbuf.h
> =A0create mode 100644 include/asm-microblaze/shmbuf.h
> =A0create mode 100644 include/asm-microblaze/shmparam.h
>=20

These files are ok, but IMHO they should be in asm-generic, since there
are already many identical copies.

While the implementation of these three, as well as ipcbuf.h and sembuf.h
could be better optimized for endianess and word size differences, I have
come to the conclusion that there is no point for them to really be
different, and uClibc expects this exact layout by default anyway.

	Arnd <><
