Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id 4B98B2BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 21:34:21 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so35970rnf
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 02:34:20 -0800 (PST)
Message-ID: <1f729c4804111902347a977b9c@mail.gmail.com>
Date: Fri, 19 Nov 2004 11:34:20 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: "Milligan, Keath" <kmilligan@austin.polycom.com>
In-Reply-To: <F3CF3D25A7F8F44BB59BC7A2CA83E30B02322252@ausexch00.austin.polycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <F3CF3D25A7F8F44BB59BC7A2CA83E30B02322252@ausexch00.austin.polycom.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Large PCI region mapping 8272
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Could someone point me in the right direction to getting everything
> initialized and mapped correctly?

I had the same impression (that the PCI initialisation) was not quite
right. After some investigation, it was me that used a wrong platform
file (overzealous deleting and copying to minimise custom code).

>From what I understand (after a brief look in the files), most of the
changes can be localised in that file.

You can enable debugging in  (IIRC) -#define DEBUG-
arch/ppc/kernel/pci.c
to have a more verbose look at what is happening.

The same goes for quircks.c and pci.c (in drivers/ somewhere).

In any case, the pci mapping calls your platform dependent fixes.=20

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
