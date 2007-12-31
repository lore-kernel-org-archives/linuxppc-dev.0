Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Please pull powerpc.git merge branch
Date: Mon, 31 Dec 2007 17:12:45 +0100
References: <18292.49574.906807.484581@cargo.ozlabs.ibm.com>
	<47757040.4020508@am.sony.com>
	<18296.18584.806777.211368@cargo.ozlabs.ibm.com>
In-Reply-To: <18296.18584.806777.211368@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712311712.46075.arnd@arndb.de>
Cc: rrnelson@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
	jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 31 December 2007, Paul Mackerras wrote:

> Geoff Levand writes:
> >=20
> > Looking at the code, it seems just when CONFIG_SPU_FS=3Dy, not when =3D=
m.

Right, thanks for reporting this.

> It looks to me that the definition of notify_spus_active under #ifndef
> MODULE in spufs/sched.c is bogus and should just be removed
> completely. =A0Also, I don't see any need for do_notify_spus_active to
> be exported.
>=20
> I propose the patch below. =A0Arnd, Jeremy, Bob, any opinions?

I'm still out of office and can't do a proper test on this in the
way I should have done on the original patch, but your assessment and
patch looks entirely correct.

Acked-by: Arnd Bergmann <arnd@arndb.de>
