Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 0938BDDF64
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 23:54:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RESEND] ehea: fix for dlpar and sysfs entries
Date: Mon, 23 Apr 2007 15:54:04 +0200
References: <200704231358.53479.ossthema@de.ibm.com>
In-Reply-To: <200704231358.53479.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704231554.06110.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 23 April 2007, Jan-Bernd Themann wrote:
> - dlpar fix:=20
> =A0=A0=A0=A0=A0=A0=A0=A0certain resources may only be allocated when first
> =A0=A0=A0=A0=A0=A0=A0=A0logical port is available, and must be removed wh=
en
> =A0=A0=A0=A0=A0=A0=A0=A0last logical port has been removed
>=20
> - sysfs entries:
> =A0=A0=A0=A0=A0=A0=A0=A0create symbolic link from each logical port to eh=
ea driver
>=20

I can't see anything wrong with the patch contents, but if you know that th=
ere
are two changes, you really should make it two separate patches.

	Arnd <><
