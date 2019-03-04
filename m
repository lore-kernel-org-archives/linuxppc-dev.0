Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E78C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 00:51:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE1520830
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 00:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE1520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CM0b0HbCzDqJW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 11:51:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CLwl2dgVzDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44CLwk4pdDz9s6w; Mon,  4 Mar 2019 11:48:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6b1200facc051a3e487a52cbabd745f7c8f4e9f8
X-Patchwork-Hint: ignore
In-Reply-To: <1546441324-19774-2-git-send-email-firoz.khan@linaro.org>
To: Firoz Khan <firoz.khan@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc: remove nargs from __SYSCALL
Message-Id: <44CLwk4pdDz9s6w@ozlabs.org>
Date: Mon,  4 Mar 2019 11:48:06 +1100 (AEDT)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-01-02 at 15:02:03 UTC, Firoz Khan wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
> 
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b1200facc051a3e487a52cbabd745f7

cheers
