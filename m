Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Cbe-oss-dev] powerpc/cell/oprofile: fix mutex locking for
	spu-oprofile
Date: Mon, 25 Aug 2008 09:55:57 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808211014.42683.arnd@arndb.de>
	<18610.20951.764057.574721@cargo.ozlabs.ibm.com>
In-Reply-To: <18610.20951.764057.574721@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808250955.57638.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 August 2008, Paul Mackerras wrote:
>=20
> > Since rc4 is out now, I understand if you feel more comfortable with
> > putting the patch into -next instead of -merge.
>=20
> Linus has been getting stricter about only putting in fixes for
> regressions and serious bugs (see his recent email to Dave Airlie on
> LKML for instance). =A0I assume that the corruption is just in the data
> that is supplied to userspace and doesn't extend to any kernel data
> structures.

That's right, please queue it for -next then.

> > Note that the second patch is trivial and fixes an oopsable condition
> > of the kernel, so at least that should still go into 2.6.27.
>=20
> OK, I'll cherry-pick that one for my next batch for Linus.

Thanks,

	Arnd <><
