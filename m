Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 2/2] Cell: Wrap master run control bit
Date: Wed, 5 Sep 2007 00:44:40 +0200
References: <46DD4783.9040103@am.sony.com> <200709050042.13926.arnd@arndb.de>
In-Reply-To: <200709050042.13926.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709050044.41091.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 September 2007, Arnd Bergmann wrote:
> On Tuesday 04 September 2007, Geoff Levand wrote:
> >=20
> > From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> >=20
> > Add platform specific SPU run control routines.
> >=20
> > The current spufs_run_spu() implementation uses the SPU master
> > run control bit (MFC_SR1[S]) to control SPE execution, but the
> > PS3 hypervisor does not support the use of this feature. =A0This
> > change adds run control wrapper routines. =A0The =A0bare metal
> > routines use the master run control bit, and the PS3 specific
> > routines use the priv2 run control register.
> >=20
> > Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

One more thing, please send spufs related patches to Jeremy instead
of to me. I'm happy to give advice on the patch contents, but
since Jeremy has taken over maintainership of spufs, merging a
patch is his decision in the end.

	Arnd <><
