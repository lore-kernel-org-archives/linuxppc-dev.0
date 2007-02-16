Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5DA5ADDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:47:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/12]: sungem_phy: support bcm5461 phy, autoneg.
Date: Fri, 16 Feb 2007 15:46:31 +0100
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702161546.31765.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 February 2007 01:43, Linas Vepstas wrote:
> Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

You only have the Signed-off-by information here and in the other
patches, but no 'From:' line.

I assume that Jeff uses the git-applymbox tool to import
mails, in which case the first line of the patch description
should be 'From: Someone Else <someone@example.com>', unless you
are the author of the patch yourself.

	Arnd <><
