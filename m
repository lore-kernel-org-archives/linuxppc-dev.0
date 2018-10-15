Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E1C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:10:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC2720652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC2720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQ2s5Mh1zF38P
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:10:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPqv5PVnzF2Ct
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:00:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPqv1dT2z9sDJ; Mon, 15 Oct 2018 15:00:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0792a2c8e0bbda3605b8d42c6b9635be7b19982a
In-Reply-To: <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
To: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/7] macintosh: Use common code to access RTC
Message-Id: <42YPqv1dT2z9sDJ@ozlabs.org>
Date: Mon, 15 Oct 2018 15:00:59 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-09-12 at 00:18:44 UTC, Finn Thain wrote:
> Now that the 68k Mac port has adopted the via-pmu driver, the same RTC
> code can be shared between m68k and powerpc. Replace duplicated code in
> arch/powerpc and arch/m68k with common RTC accessors for Cuda and PMU.
> 
> Drop the problematic WARN_ON which was introduced in commit 22db552b50fa
> ("powerpc/powermac: Fix rtc read/write functions").
> 
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0792a2c8e0bbda3605b8d42c6b9635

cheers
