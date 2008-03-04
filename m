Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id BF697DDEA3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 11:42:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Date: Tue, 4 Mar 2008 01:42:05 +0100
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080303132107.67200634@weaponx>
	<20080303214028.GE4712@localdomain>
In-Reply-To: <20080303214028.GE4712@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803040142.06533.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 March 2008, Nathan Lynch wrote:
> I agree. =A0Josh's patch is immediately useful to other code as-is.
>=20
> used-by-rtas is powerpc-specific and doesn't belong in drivers/of IMO.

Ok, makes sense, plus paulus looked at the PAPR spec with me and we found
that used-by-rtas doesn't necessarily mean "don't touch" in all
circumstances, so original patch

Acked-by: Arnd Bergmann <arnd@arndb.de>
