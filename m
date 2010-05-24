Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADBA3B7D42
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 05:02:07 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/fsl head: move the entry setup code into a
	seperate file
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270412343-19334-3-git-send-email-sebastian@breakpoint.cc>
Date: Mon, 24 May 2010 14:01:48 -0500
Message-Id: <2E25F460-0EA6-4035-8A38-96D42CC9CD24@kernel.crashing.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-3-git-send-email-sebastian@breakpoint.cc>
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
> This patch only moves the initial entry code which setups the mapping
> from what ever to KERNELBASE into a seperate file. No code change has
> been made here.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |  200 =
+++++++++++++++++++++++++
> arch/powerpc/kernel/head_fsl_booke.S          |  199 =
+------------------------
> 2 files changed, 201 insertions(+), 198 deletions(-)
> create mode 100644 arch/powerpc/kernel/fsl_booke_entry_mapping.S

applied to next

- k=
