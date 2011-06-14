Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78E0EB6F7E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 09:15:32 +1000 (EST)
Received: from mail43-tx2 (localhost.localdomain [127.0.0.1])	by
	mail43-tx2-R.bigfish.com (Postfix) with ESMTP id A4F711418119	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:15:28 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.253])	by
	mail43-tx2.bigfish.com (Postfix) with ESMTP id 84039490051	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:15:28 +0000 (UTC)
Message-ID: <4DF7EB8E.8020308@freescale.com>
Date: Tue, 14 Jun 2011 18:15:26 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
In-Reply-To: <20110614181406.294cdf5f@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="ISO-8859-1"
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

Scott Wood wrote:
> FWIW, it's not supported under KVM either -- though we don't support an SMP
> guest under KVM yet, and KVM silently ignores it rather than logs errors as
> the FSL HV does.

Does KVM set the root compatible to "fsl,P4080DS-hv"?

-- 
Timur Tabi
Linux kernel developer at Freescale
