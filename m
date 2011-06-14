Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E253FB6F86
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 09:25:37 +1000 (EST)
Received: from mail60-am1 (localhost.localdomain [127.0.0.1])	by
	mail60-am1-R.bigfish.com (Postfix) with ESMTP id A1D5C177828A	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:25:32 +0000 (UTC)
Received: from AM1EHSMHS011.bigfish.com (unknown [10.3.201.249])	by
	mail60-am1.bigfish.com (Postfix) with ESMTP id 604DF2A0050	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:25:22 +0000 (UTC)
Date: Tue, 14 Jun 2011 18:25:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Message-ID: <20110614182517.776d7e77@schlenkerla.am.freescale.net>
In-Reply-To: <4DF7EB8E.8020308@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jun 2011 18:15:26 -0500
Timur Tabi <timur@freescale.com> wrote:

> Scott Wood wrote:
> > FWIW, it's not supported under KVM either -- though we don't support an SMP
> > guest under KVM yet, and KVM silently ignores it rather than logs errors as
> > the FSL HV does.
> 
> Does KVM set the root compatible to "fsl,P4080DS-hv"?

No, Qemu/KVM like to pretend they're fully emulating concrete hardware,
even though there's stuff missing.

The only upstream e500 KVM platform is currently mpc8544ds.

For now, there's no SMP KVM guest support.  Maybe kexec can be fixed to not
hard-reset the core by the time that changes. :-)

-Scott
