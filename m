Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A1C9B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:13:01 +1000 (EST)
Subject: Re: [PATCH 11/14] 85xx: merge 32-bit QorIQ with DPA boards support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-12-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:12:54 -0500
Message-Id: <5F3E28E8-5E00-436F-9389-D0518CB667B1@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-12-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> Board support files for p4080ds, p3041ds and p2040rdb don't differ at
> all (all differencies are hidden in dts files). So merge them into
> single board file containing all necessary stuff.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig                |   32 +------
> arch/powerpc/platforms/85xx/Makefile               |    4 +-
> arch/powerpc/platforms/85xx/p2040_rdb.c            |   88 =
-------------------
> arch/powerpc/platforms/85xx/p3041_ds.c             |   90 =
--------------------
> .../platforms/85xx/{p4080_ds.c =3D> qoriq_dpa_ds.c}  |   24 +++--
> 5 files changed, 20 insertions(+), 218 deletions(-)
> delete mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c
> delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
> rename arch/powerpc/platforms/85xx/{p4080_ds.c =3D> qoriq_dpa_ds.c} =
(72%)

NAK, there are other reasons these are split like they are today.

- k=
