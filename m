Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08839B70B8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:03:32 +1100 (EST)
Received: from mail61-am1 (localhost.localdomain [127.0.0.1])	by
	mail61-am1-R.bigfish.com (Postfix) with ESMTP id A84D0F0814C	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:03:27 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.252])	by
	mail61-am1.bigfish.com (Postfix) with ESMTP id 911A41B58046	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:03:27 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9763TLp013231	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 23:03:30 -0700 (MST)
Subject: Re: [PATCH 2/4] powerpc/85xx: Remove call to mpic_teardown_this_cpu
	in kexec
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284677906-23787-2-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:00:34 -0500
Message-ID: <9A405810-5F19-44B2-BE38-145F74FBB4CF@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
	<1284677906-23787-2-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2010, at 5:58 PM, Matthew McClintock wrote:

> We no longer need to call this explicitly as a generic version is
> called by default
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)

applied to next

- k
