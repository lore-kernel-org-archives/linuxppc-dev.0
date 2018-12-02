Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9DC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 11:06:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FE72082F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 11:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FE72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4375061cF9zDqZP
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 22:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4374vg2lYZzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2018 22:02:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4374vf45rVz9sDF; Sun,  2 Dec 2018 22:02:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bf3d6afbb234156749b640b6c50f714967a85964
X-Patchwork-Hint: ignore
In-Reply-To: <d3aa7c5adee1e3cedeb65661545c82d30faafc8f.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Look for "stdout-path" when setting up legacy consoles
Message-Id: <4374vf45rVz9sDF@ozlabs.org>
Date: Sun,  2 Dec 2018 22:02:05 +1100 (AEDT)
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
Cc: Rob Herring <robh@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-30 at 03:54:09 UTC, Benjamin Herrenschmidt wrote:
> Commit 78e5dfea8 "powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'"
> broke the default console on a number of embedded PowerPC systems, because it
> failed to also update the code in arch/powerpc/kernel/legacy_serial.c to
> look for that property in addition to the old one.
> 
> This fixes it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 78e5dfea8 powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bf3d6afbb234156749b640b6c50f71

cheers
