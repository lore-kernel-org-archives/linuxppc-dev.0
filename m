Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77517C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:36:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16B64DA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16B64DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW2l26lFczF32v
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:36:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW0JF6vnFzDwxD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:46:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW0JC6G4Nz9tlM; Wed,  3 Feb 2021 22:46:19 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20210129071745.111466-1-ravi.bangoria@linux.ibm.com>
References: <20210129071745.111466-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/sstep: Fix array out of bound warning
Message-Id: <161235275169.1521894.17491918890471924956.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:46:19 +1100 (AEDT)
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
Cc: naveen.n.rao@linux.ibm.com, jniethe5@gmail.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 29 Jan 2021 12:47:45 +0530, Ravi Bangoria wrote:
> Compiling kernel with -Warray-bounds throws below warning:
> 
>   In function 'emulate_vsx_store':
>   warning: array subscript is above array bounds [-Warray-bounds]
>   buf.d[2] = byterev_8(reg->d[1]);
>   ~~~~~^~~
>   buf.d[3] = byterev_8(reg->d[0]);
>   ~~~~~^~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/sstep: Fix array out of bound warning
      https://git.kernel.org/powerpc/c/344717a14cd7272f88346022a77742323346299e

cheers
