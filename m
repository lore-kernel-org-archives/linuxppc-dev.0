Return-Path: <PeterHuewe@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DEDA5B7DB3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 04:42:25 +1000 (EST)
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Date: Tue, 11 May 2010 20:42:14 +0200
References: <201005051720.22617.PeterHuewe@gmx.de>
In-Reply-To: <201005051720.22617.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005112042.14889.PeterHuewe@gmx.de>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>,
	linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch 05 Mai 2010 17:20:21 schrieb Peter H=FCwe:
> From: Peter Huewe <peterhuewe@gmx.de>
>=20
> This patch adds a missing include linux/delay.h to prevent
> build failures[1-5]
>=20
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
Any updates on this patch?
Issue still exists with today's linux-next tree

Thanks,
Peter
