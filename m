Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF0C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:00:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE94F20705
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE94F20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48smWd1J9BzDr3l
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:00:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48smMT0hB0zDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 23:53:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48smMS2jDxz9sT6; Wed,  1 Apr 2020 23:53:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a7032637b54186e5649917679727d7feaec932b1
In-Reply-To: <20190812215052.71840-10-ndesaulniers@google.com>
To: Nick Desaulniers <ndesaulniers@google.com>, akpm@linux-foundation.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 10/16] powerpc: prefer __section and __printf from
 compiler_attributes.h
Message-Id: <48smMS2jDxz9sT6@ozlabs.org>
Date: Wed,  1 Apr 2020 23:53:07 +1100 (AEDT)
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
Cc: Rob Herring <robh@kernel.org>, Song Liu <songliubraving@fb.com>,
 Martin KaFai Lau <kafai@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 miguel.ojeda.sandonis@gmail.com, Geoff Levand <geoff@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, jpoimboe@redhat.com, sedat.dilek@gmail.com,
 yhs@fb.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-08-12 at 21:50:43 UTC, Nick Desaulniers wrote:
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7032637b54186e5649917679727d7feaec932b1

cheers
