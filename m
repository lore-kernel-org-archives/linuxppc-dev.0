Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 042C6B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:19:05 +1000 (EST)
Subject: Re: [PATCH 06/14] 85xx/sbc8560: correct compilation if
	CONFIG_PHYS_ADDR_T_64BIT is set
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-7-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:18:59 -0500
Message-Id: <DF566035-7DE4-4AD1-9E79-DF5A8813AC86@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-7-git-send-email-dbaryshkov@gmail.com>
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

> If CONFIG_PHYS_ADDR_T_64BIT is set, compilation of sbc8560 fails with
> the following error:
>=20
> arch/powerpc/platforms/85xx/sbc8560.c: In function =
=91sbc8560_bdrstcr_init=92:
> arch/powerpc/platforms/85xx/sbc8560.c:286: error: format =91%x=92 =
expects type =91unsigned int=92, but argument 2 has type =
=91resource_size_t=92
>=20
> Fix that by using %pR format instead of just printing the start of
> resource.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/sbc8560.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next-3.2

- k=
