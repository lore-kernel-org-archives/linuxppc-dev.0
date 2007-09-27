Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4E345DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 21:41:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] ibmebus: Add device creation and bus probing based on
	of_device
Date: Thu, 27 Sep 2007 13:27:04 +0200
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261145.22278.fenkes@de.ibm.com>
In-Reply-To: <200709261145.22278.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271327.05793.arnd@arndb.de>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Joachim Fenkes wrote:
> The devtree root is now searched for devices matching a built-in whitelist
> during boot, so these devices appear on the bus from the beginning. It is
> still possible to manually add/remove devices to/from the bus by using the
> probe/remove sysfs interface. Also, when a device driver registers itself,
> the devtree is matched against its matchlist.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
