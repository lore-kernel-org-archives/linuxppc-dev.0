Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6788367BBD
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 09:20:09 +1100 (EST)
Message-ID: <4575F092.8060604@am.sony.com>
Date: Tue, 05 Dec 2006 14:20:02 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cell: fix missing spu.h header export
References: <4575E712.5020103@am.sony.com> <200612052306.42632.arnd@arndb.de>
In-Reply-To: <200612052306.42632.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 05 December 2006 22:39, Geoff Levand wrote:
>>=20
>> Add spu.h to the list of exported headers. =EF=BF=BDFixes this error w=
hen
>> using 'make headers_check' or when CONFIG_HEADERS_CHECK=3Dy:
>>=20
>> =EF=BF=BD asm/spu_info.h requires asm/spu.h, which does not exist in e=
xported headers
>>=20
>>=20
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
> Sorry, wrong fix. I had a better one already but haven't gotten around
> to post it. spu_info.h should be in unifdef-y and spu.h should stay
> internal to the kernel. I'll follow up with my patch.

Dang your fast, I was just going to post that!
