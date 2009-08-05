Return-Path: <Matthias.Lange@beissbarth.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94A2AB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 18:14:58 +1000 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by ozlabs.org (Postfix) with ESMTP id 1AB99DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 18:14:58 +1000 (EST)
From: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
To: Benjamin Krill <ben@codiert.org>
Date: Wed, 5 Aug 2009 10:14:49 +0200
Subject: RE: Spansion S25FL128-Flash and MTD
Message-ID: <44C5CFA72BC0E242A53B64DC1E67DEB80FB9896677@SI-MBX10.de.bosch.com>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80FB989659B@SI-MBX10.de.bosch.com>
	<20090805074501.GN22901@codiert.org>
In-Reply-To: <20090805074501.GN22901@codiert.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi,
>
> >                #address-cells =3D <1>;
> >                #size-cells =3D <1>;
> >                rootfs@800000 {
>
> The partition must be called
>       partition@...
>

Thanks, though that didn't solve my problem. The naming seems to be a bug i=
n booting-without-of.txt where the example in section "CFI or JEDEC memory-=
mapped NOR flash" uses "firmware" as the node name.

Regards,
Matthias.
