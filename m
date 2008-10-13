Return-Path: <robert.richter@amd.com>
Date: Mon, 13 Oct 2008 17:13:07 +0200
From: Robert Richter <robert.richter@amd.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] powerpc/cell/oprofile: fix mutex locking for
	spu-oprofile
Message-ID: <20081013151307.GA23557@erda.amd.com>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<18610.20951.764057.574721@cargo.ozlabs.ibm.com>
	<200808250955.57638.arnd@arndb.de>
	<200810131653.29631.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <200810131653.29631.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 13.10.08 16:53:28, Arnd Bergmann wrote:
> On Monday 25 August 2008, Arnd Bergmann wrote:
> > On Monday 25 August 2008, Paul Mackerras wrote:
> > >=20
> > > > Since rc4 is out now, I understand if you feel more comfortable w=
ith
> > > > putting the patch into -next instead of -merge.
> > >=20
> > > Linus has been getting stricter about only putting in fixes for
> > > regressions and serious bugs (see his recent email to Dave Airlie o=
n
> > > LKML for instance). =A0I assume that the corruption is just in the =
data
> > > that is supplied to userspace and doesn't extend to any kernel data
> > > structures.
> >=20
> > That's right, please queue it for -next then.
>=20
> I just realized that this patch never made it into powerpc-next after
> all, neither benh nor paulus version. Whoever is handling it today,
> could you please pull
>=20
>  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge
>=20
> to get this commit below. I have rebased it on top of the current
> benh/powerpc/next branch.

All powerpc oprofile patches are in this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git powerpc-f=
or-paul

Pending patches are:

Carl Love (1):
      powerpc/cell/oprofile: fix mutex locking for spu-oprofile

Roel Kluin (1):
      powerpc/cell/oprofile: vma_map: fix test on overlay_tbl_offset

Please pull from there.

-Robert

--=20
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
