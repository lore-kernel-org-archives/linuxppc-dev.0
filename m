Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 506A1B70CC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:00:37 +1100 (EST)
Received: from mail74-am1 (localhost.localdomain [127.0.0.1])	by
	mail74-am1-R.bigfish.com (Postfix) with ESMTP id 4D64A78214	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:00:33 +0000 (UTC)
Received: from am1ehsmhs003.bigfish.com (unknown [10.3.201.243])	by
	mail74-am1.bigfish.com (Postfix) with ESMTP id 21E5A19B8054	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:00:33 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9760U7E006926	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 23:00:30 -0700 (MST)
Subject: Re: [PATCH 1/4] powerpc/kexec: make masking/disabling interrupts
	generic
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284677906-23787-1-git-send-email-msm@freescale.com>
Date: Thu, 7 Oct 2010 01:00:29 -0500
Message-ID: <8104206D-8663-4E18-851E-E540211286F5@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
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

> Right now just the kexec crash pathway turns turns off the
> interrupts. Pull that out and make a generic version for
> use elsewhere
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/include/asm/kexec.h       |    1 +
> arch/powerpc/kernel/crash.c            |   13 +------------
> arch/powerpc/kernel/machine_kexec.c    |   24 ++++++++++++++++++++++++
> arch/powerpc/kernel/machine_kexec_32.c |    4 ++++
> 4 files changed, 30 insertions(+), 12 deletions(-)

applied to next

- k
