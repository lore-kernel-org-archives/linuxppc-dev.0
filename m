Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 429C6B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 17:25:40 +1100 (EST)
Received: from mail29-am1 (localhost.localdomain [127.0.0.1])	by
	mail29-am1-R.bigfish.com (Postfix) with ESMTP id 8D34810B03B0	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 06:10:26 +0000 (UTC)
Received: from am1ehsmhs004.bigfish.com (unknown [10.3.201.251])	by
	mail29-am1.bigfish.com (Postfix) with ESMTP id 58D85D9004E	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2010 06:10:26 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o976ASaG013889	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 6 Oct 2010 23:10:28 -0700 (MST)
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: Add support to boot from core
	other than 0
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1283297085-3455-2-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:10:22 -0500
Message-ID: <DABFAE6E-41F8-4B32-B76F-ADEB5E3D55F4@freescale.com>
References: <1283297085-3455-1-git-send-email-msm@freescale.com>
	<1283297085-3455-2-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 6:24 PM, Matthew McClintock wrote:

> First we check to see if we are the first core booting up. This
> is accomplished by comparing the boot_cpuid with -1, if it is we
> assume this is the first core coming up.
> 
> Secondly, we need to update the initial thread info structure
> to reflect the actual cpu we are running on otherwise
> smp_processor_id() and related functions will return the default
> initialization value of the struct or 0.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |   10 ++++++++--
> arch/powerpc/kernel/setup_32.c       |    2 +-
> 2 files changed, 9 insertions(+), 3 deletions(-)

Are we sticking with this or not?

- k
