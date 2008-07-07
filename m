Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu aware cpufreq
	governor
Date: Mon, 7 Jul 2008 11:01:11 +0200
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
	<1215408119.8970.67.camel@pasglop>
In-Reply-To: <1215408119.8970.67.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807071101.11481.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Benjamin Herrenschmidt wrote:
> Also, there's the question of whether this should also go in
> drivers/cpufreq or not and should be reviewed by the cpufreq
> maintainer (whoever that is), no ?

Good point. Let's see if Dave Jones has a few cycles for a review
of this.

	Arnd <><
