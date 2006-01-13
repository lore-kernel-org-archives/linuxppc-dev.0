Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <17351.28085.401798.395945@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jan 2006 20:07:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Cedric Pradalier <cedric.pradalier@free.fr>
Subject: Re: Fw:   therm_adm103x: inquiry
In-Reply-To: <20060112215200.680a8cc1.cedric.pradalier@free.fr>
References: <20060112215200.680a8cc1.cedric.pradalier@free.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cedric Pradalier writes:

> As far as I can see, this module seems mature enough for
> inclusion in official kernel.
>=20
> A tested patch against 2.6.14 is available at:
> http://cedric.pradalier.free.fr/ibook2/adm103x-2.6.14.diff.gz
>=20
> I've not tested it yet for 2.6.15.=20
>=20
> Some details, from the link site above:
>=20
> The module provides and sysfs access to the adm103x fan
> control parameters. For instance
>=20
> =09  #cat /sys/device/temperatures/info=3F=20
> =09  T:51=B0C S:56=B0C R:10=B0C  <-- sensor 0
> =09  T:48=B0C S:76=B0C R:10=B0C  <-- sensor 1

I think we should remove the degree symbol, since it is neither ASCII
nor UTF-8, and it is unnecessary.  Apart from that it sounds OK; we
would have to see the code before deciding whether to include it.

Paul.
