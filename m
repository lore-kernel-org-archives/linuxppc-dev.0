Return-Path: <SRS0=N2pq=UR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24C3C31E51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:26:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF5D2082C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF5D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SnPr75QmzDqRy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 22:26:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SnKk4c9CzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2019 22:23:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnKj1dGhz9s9y;
 Tue, 18 Jun 2019 22:23:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/powerpc: Add missing newline at end of file
In-Reply-To: <20190617145204.6810-1-geert+renesas@glider.be>
References: <20190617145204.6810-1-geert+renesas@glider.be>
Date: Tue, 18 Jun 2019 22:23:02 +1000
Message-ID: <87muifozfd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geert Uytterhoeven <geert+renesas@glider.be> writes:
> "git diff" says:
>
>     \ No newline at end of file
>
> after modifying the file.

Is that a problem?

Just curious because it was presumably me that broke it :)

cheers

> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> index ba919308fe3052f3..16861ab840f57e90 100644
> --- a/tools/testing/selftests/powerpc/mm/.gitignore
> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> @@ -3,4 +3,4 @@ subpage_prot
>  tempfile
>  prot_sao
>  segv_errors
> -wild_bctr
> \ No newline at end of file
> +wild_bctr
> -- 
> 2.17.1
