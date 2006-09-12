Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B1E54679FD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 07:16:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc: allow PHBs anywhere in the device
	tree
Date: Tue, 12 Sep 2006 23:16:21 +0200
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
	<20060912145438.30b6bf80@localhost.localdomain>
In-Reply-To: <20060912145438.30b6bf80@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200609122316.21820.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 September 2006 21:54, Olof Johansson wrote:
> !strcasecmp(...) instead?

I do that normally for functions that return either a truth value
or a pointer to an object that may be NULL, whereas strcasecmp
returns a numerical value that I'm checking for a specific result.
This is also consistant with how it is used elsewhere in the file.

> Do they ever exist in non-lowercase versions? Old code just did
> strcmp().

I took that from device_is_compatible(), which also does
strncasecmp, so I assumed that was done for a reason.

> > + *=A0=A0=A0@from:=A0=A0The node to start searching from or NULL, the n=
ode
> > + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0you pass will not be searched, only=
 the next one
> > + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0will; typically, you pass what the =
previous call
> > + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0returned. of_node_put() will be cal=
led on it
>=20
> Convention seems to be to call this "prev", not "from"?

ok

	Arnd <><
