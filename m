Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57F1010096B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:00:48 +1100 (EST)
Received: from mail16-am1 (localhost.localdomain [127.0.0.1])	by
	mail16-am1-R.bigfish.com (Postfix) with ESMTP id B7B1C5483E0	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:00:43 +0000 (UTC)
Received: from am1ehsmhs004.bigfish.com (unknown [10.3.201.253])	by
	mail16-am1.bigfish.com (Postfix) with ESMTP id 93AED125004C	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:00:43 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9760eQo006936	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 23:00:40 -0700 (MST)
Subject: Re: [PATCH 3/4] powerpc/85xx: Minor fixups for kexec on 85xx
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284677906-23787-3-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:00:39 -0500
Message-ID: <340147DD-2E65-44AB-BB5B-DEFF9681F2C4@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
	<1284677906-23787-3-git-send-email-msm@freescale.com>
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

> Make kexec_down_cpus atmoic since it will be incremented by all
> cores as they are coming down
> 
> Remove duplicate calls to mpc85xx_smp_kexec_down, now it's called
> by the crash and normal kexec pathway only once
> 
> Increase the timeout to wait for other cores to shutdown
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |   24 +++++++++++-------------
> 1 files changed, 11 insertions(+), 13 deletions(-)

applied to next

- k
