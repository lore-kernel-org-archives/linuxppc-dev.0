Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD235B7D59
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 05:02:23 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
Date: Mon, 24 May 2010 14:01:55 -0500
Message-Id: <00E9E395-DA5C-4503-B279-A209EC1E677C@kernel.crashing.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 4, 2010, at 3:19 PM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> This adds support kexec on FSL-BookE where the MMU can not be simply
> switched off. The code borrows the initial MMU-setup code to create =
the
> identical mapping mapping. The only difference to the original boot =
code
> is the size of the mapping(s) and the executeable address.
> The kexec code maps the first 2 GiB of memory in 256 MiB steps. This
> should work also on e500v1 boxes.
> SMP support is still not available.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/Kconfig                          |    2 +-
> arch/powerpc/include/asm/kexec.h              |   13 +++++++++
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |   37 =
+++++++++++++++++++++++++
> arch/powerpc/kernel/head_fsl_booke.S          |    2 +
> arch/powerpc/kernel/misc_32.S                 |   17 +++++++++++
> 5 files changed, 70 insertions(+), 1 deletions(-)

applied to next

- k=
