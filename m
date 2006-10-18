Return-Path: <olaf@ibook.aepfle.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id A6B8667BCC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 17:39:08 +1000 (EST)
Date: Wed, 18 Oct 2006 09:38:51 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061018073851.GA13083@aepfle.de>
References: <4534BE9D.7030908@bplan-gmbh.de> <20061017132243.GA6773@lst.de>
	<4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1161152109.7906.6.camel@localhost.localdomain>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, tilmann@bitterberg.de,
	Sven Luther <sl@bplan-gmbh.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 18, Michael Ellerman wrote:

> But it's called '/proc/ppc64' right now on lots of machines, so you
> can't go changing it.

if test -d /proc/ppc64 .. is a quick way to check wether the system is
64bit or not. Similar to if test -d /proc/iSeries ..
You better leave that simple interface.
