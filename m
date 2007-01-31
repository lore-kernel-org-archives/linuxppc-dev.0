Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: maynardj@us.ibm.com
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 3/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Wed, 31 Jan 2007 01:35:42 +0100
References: <45BE4ED0.5030808@us.ibm.com> <200701300524.32556.arnd@arndb.de>
	<45BF64DC.7040506@us.ibm.com>
In-Reply-To: <45BF64DC.7040506@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701310135.43383.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 January 2007 16:31, Maynard Johnson wrote:
>=20
> > On solution would be to move the notify_active flag from ctx->spu
> > into ctx itself, but maybe there are other ways to solve this.
> In an earlier review of this patch, Christopher Hellwig suggested I move=
=20
> the notify_active flag to be a bit in the sched_flags field that's added=
=20
> in his scheduler patch series. =A0If this patch series will be a availabl=
e=20
> in an "Arnd" tree that we'll be using for our current OProfile=20
> development, perhaps I should wait until that time to change this, since=
=20
> the window of vulnerability is quite small. =A0What do you think?

Sounds good to me.

	Arnd <><
