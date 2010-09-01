Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBD57B7114
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 16:44:54 +1000 (EST)
Subject: Re: [PATCH v2 1/4] fsl_rio: fix compile errors
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTikcfOQOEK=-oV2DBN7et9jkHM5s-v08EWHBjKno@mail.gmail.com>
Date: Wed, 1 Sep 2010 01:44:46 -0500
Message-Id: <F508DEEC-D2A3-406E-AC8C-45DCC466C769@kernel.crashing.org>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<C038AA46-E821-49EF-8958-747953FF56A0@kernel.crashing.org>
	<AANLkTikcfOQOEK=-oV2DBN7et9jkHM5s-v08EWHBjKno@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 10:40 PM, Li Yang wrote:

> On Wed, Sep 1, 2010 at 5:39 AM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
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
>> applied to merge
>=20
> Thanks, Kumar.
>=20
> How about the other ones in the series?

I want to rework how the whole RIO mcheck works and will do so for =
2.6.37.  Part of the problem I have is that we are ignoring the fact =
that this code isn't right for 8641 support of SRIO.

- k
