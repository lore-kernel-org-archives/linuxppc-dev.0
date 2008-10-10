Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 96087474C1
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:18:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc/40x: Add support for PowerPC 405EZ Acadia
	board
Date: Fri, 10 Oct 2008 18:16:55 +0200
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
	<200810101758.54939.arnd@arndb.de>
	<20081010160522.GB13966@yoda.jdub.homelinux.org>
In-Reply-To: <20081010160522.GB13966@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101816.55399.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 October 2008, Josh Boyer wrote:
> It would, except for timing. =A0I didn't get a chance to convert
> 40x over before the merge window opened and I'd rather not try
> to cram it in during the 1 week we have. =A0And Acadia is ported
> now (and has been for a few weeks), so getting that in seemed
> to be an easier route to take.
>=20
> I do have plans to convert 40x for 2.6.29, and if there are
> major objections I can hold off Acadia until then. =A0I just
> don't like holding back board ports for the "next re-org".
>=20

How about just renaming 40x/acadia.c to 40x/ppc405_simple.c
without the merge? Then you can merge in the other platforms
as time permits and any other new ones can start using the
_simple platform right away.

	Arnd <><
