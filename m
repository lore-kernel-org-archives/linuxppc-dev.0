Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id ADF29DDF20
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 16:17:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RESEND] powerpc: Add 82xx/83xx/86xx to 6xx Multiplatform
Date: Tue, 1 Jul 2008 08:17:44 +0200
References: <Pine.LNX.4.64.0807010030240.23830@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0807010030240.23830@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807010817.44804.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 July 2008, Kumar Gala wrote:
> There isn't any reason at this point that we can't build 82xx, 83xx & 86xx
> support in with the other 6xx based boards. =A0Twiddle the Kconfigs to al=
low
> this.
>=20
> This allows us to remove the machine type selection for related to 6xx.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for doing this now. I had sent a similar patch last year when there
were still bugs in the source preventing it from working, but now it all
looks good.
