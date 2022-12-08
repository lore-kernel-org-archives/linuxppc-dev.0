Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11423C63703
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 12:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSYsn3mMLz3fBR
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 23:50:37 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYrf1qqMz2xKX
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:49:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrc0VgBz4xRB;
	Thu,  8 Dec 2022 23:49:36 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Gray <bgray@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221128041948.58339-1-bgray@linux.ibm.com>
References: <20221128041948.58339-1-bgray@linux.ibm.com>
Subject: Re: (subset) [PATCH v3 0/7] Expand selftest utils
Message-Id: <167050320315.1457988.1297752497833504512.b4-ty@ellerman.id.au>
Date: Thu, 08 Dec 2022 23:40:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: ajd@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 28 Nov 2022 15:19:41 +1100, Benjamin Gray wrote:
> Started this when writing tests for a feature I'm working on, needing a way to
> read/write numbers to system files. After writing some utils to safely handle
> file IO and parsing, I realised I'd made the ~6th file read/write implementation
> and only(?) number parser that checks all the failure modes when expecting to
> parse a single number from a file.
> 
> So these utils ended up becoming this series. I also modified some other test
> utils I came across while doing so. My understanding is selftests are not expected
> to be backported, so I wasn't concerned about only introducing new utils and leaving
> the existing implementations be.
> 
> [...]

Patches 1 & 2 applied to powerpc/next.

[1/7] selftests/powerpc: Use mfspr/mtspr macros
      https://git.kernel.org/powerpc/c/aecfd680099ba518c34dff2941017c5aa97def52
[2/7] selftests/powerpc: Add ptrace setup_core_pattern() null-terminator
      https://git.kernel.org/powerpc/c/94ba4f2c33f42dae7813dc169a177e922a39560c

cheers
