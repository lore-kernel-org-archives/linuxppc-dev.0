Return-Path: <ben@codiert.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0B71B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 17:45:58 +1000 (EST)
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5958BDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 17:45:57 +1000 (EST)
Date: Wed, 5 Aug 2009 09:45:01 +0200
From: Benjamin Krill <ben@codiert.org>
To: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
Subject: Re: Spansion S25FL128-Flash and MTD
Message-ID: <20090805074501.GN22901@codiert.org>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80FB989659B@SI-MBX10.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <44C5CFA72BC0E242A53B64DC1E67DEB80FB989659B@SI-MBX10.de.bosch.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

>                #address-cells = <1>;
>                #size-cells = <1>;
>                rootfs@800000 {

The partition must be called
	partition@...

>                        label = "rootfs";
>                        reg = <0x800000 0x800000>;
>                };
>        };
>};

cheers
 ben
