Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77F87B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 04:01:01 +1000 (EST)
Subject: Re: [PATCH v2 1/4] fsl_rio: fix compile errors
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100805125415.3a939502@schlenkerla.am.freescale.net>
Date: Thu, 5 Aug 2010 13:00:53 -0500
Message-Id: <EAC48836-5544-41DB-BBCA-E3DF27DAB572@kernel.crashing.org>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<F653C93C-5650-4D7B-99F7-090436CFC533@kernel.crashing.org>
	<20100805125415.3a939502@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2010, at 12:54 PM, Scott Wood wrote:

> On Thu, 5 Aug 2010 12:39:48 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>=20
>>=20
>> On Jun 18, 2010, at 1:24 AM, Li Yang wrote:
>>=20
>>> Fixes the following compile problem on E500 platforms:
>>> arch/powerpc/sysdev/fsl_rio.c: In function =
'fsl_rio_mcheck_exception':
>>> arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared =
(first use in this function)
>>>=20
>>> Also fixes the compile problem on non-E500 platforms.
>>>=20
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/fsl_rio.c |    6 +++++-
>>> 1 files changed, 5 insertions(+), 1 deletions(-)
>>=20
>> I'm confused is this handler not relevant for e500MC?  The 2nd patch =
makes me thing it is.
>=20
> It is, though it needs to use a different MCSR bit on e500mc.
>=20
> Are you referring to the #ifdef CONFIG_E500?  CONFIG_PPC_E500MC =
depends
> on CONFIG_E500...

Ah, that makes a bit more sense now.

- k=
