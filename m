Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 65079DE05D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 04:40:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/5] powerpc/ibm_iic: remove support for OCP
Date: Tue, 10 Jun 2008 20:40:13 +0200
References: <20080610142702.354823071@arndb.de>
	<20080610142947.974805307@arndb.de>
	<20080611022442.80fc8092.sfr@canb.auug.org.au>
In-Reply-To: <20080611022442.80fc8092.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806102040.13516.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	i2c@lm-sensors.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 June 2008, Stephen Rothwell wrote:
> There is already a patch in the i2c tree to do this one. =A0Commit id
> c73327b0f4d96f76a9b57eecdc7594a98c04ab62 ("i2c-ibm_iic: Remove deprecated
> OCP style part") in today's linux-next tree if you want to compare.

Ok, I removed it from my git tree now.

	Arnd <><
