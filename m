Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/7] ucc_geth driver fixes mostly as a result of QE lib
	changes
Date: Tue, 3 Oct 2006 22:16:47 +1000
References: <20061002200926.6ca3a9f0.kim.phillips@freescale.com>
In-Reply-To: <20061002200926.6ca3a9f0.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610032216.47607.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim,

> +=A0=A0=A0=A0=A0=A0=A0ph =3D (phandle *) get_property(np, "phy-handle", N=
ULL);

get_property() now returns const void *, so there should be no need to=20
cast this - just define ph as a const phandle *.

The same applies to the other invocations of get_property in this=20
series.

Regards,


Jeremy
