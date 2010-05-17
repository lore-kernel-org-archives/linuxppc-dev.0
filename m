Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0C26B7DC2
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:31:02 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/e500mc: Implement machine check handler.
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270705102-18343-1-git-send-email-galak@kernel.crashing.org>
Date: Mon, 17 May 2010 13:30:57 -0500
Message-Id: <D8028169-6752-4A70-82C3-28B8EAB8FBF0@kernel.crashing.org>
References: <1270705102-18343-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2010, at 12:38 AM, Kumar Gala wrote:

> From: Scott Wood <scottwood@freescale.com>
>=20
> Most of the MSCR bit assigments are different in e500mc versus
> e500, and they are now write-one-to-clear.
>=20
> Some e500mc machine check conditions are made recoverable (as long as
> they aren't stuck on), most notably L1 instruction cache parity =
errors.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Fix build error
>=20
> arch/powerpc/include/asm/cputable.h  |    1 +
> arch/powerpc/include/asm/reg_booke.h |   33 +++++++++----
> arch/powerpc/kernel/cputable.c       |    2 +-
> arch/powerpc/kernel/traps.c          |   88 =
+++++++++++++++++++++++++++++++++-
> 4 files changed, 112 insertions(+), 12 deletions(-)

applied to next

- k=
