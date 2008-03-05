Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E0BDDDDF0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:51:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/11] hvcbeat: fix buffer manipulation
Date: Wed, 5 Mar 2008 12:51:06 +0100
References: <20080305.174154.660275727.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.174154.660275727.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051251.07355.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 March 2008, Ishizaki Kou wrote:
> This patch fixes a potential bug at drivers/char/hvc_beat.c.
> =A0- hvc_put_term_char routine will decrement "rest" variable twice,
> =A0 =A0and forget to advance "buf" pointer by "nlen" bytes.
> This bug was not hit because the output handler in
> drivers/char/hvc_console.c splits given output into 16 bytes
> at maximum.
>=20
> Reported-by: Timur Tabi <timur@freescale.com>
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

obviously correct
