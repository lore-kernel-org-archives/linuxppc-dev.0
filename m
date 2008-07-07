Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu aware cpufreq
	governor
Date: Mon, 7 Jul 2008 10:58:09 +0200
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
	<20080707162457.e5f3cb9d.sfr@canb.auug.org.au>
In-Reply-To: <20080707162457.e5f3cb9d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807071058.09559.arnd@arndb.de>
Cc: Christian Krafft <parabelboi@bopserverein.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Stephen Rothwell wrote:
> > +
> > +=A0=A0=A0=A0=A0CALC_LOAD(info->busy_spus, EXP, busy_spus * FIXED_1);
> > +=A0=A0=A0=A0=A0pr_debug(KERN_ERR "cpu %d: busy_spus=3D%d, info->busy_s=
pus=3D%d\n", cpu, busy_spus, info->busy_spus);
>=20
> Split this line.

Right, also: leave out the KERN_ERR in pr_debug, and use %ld for info->busy=
_spus.

	Arnd <><
