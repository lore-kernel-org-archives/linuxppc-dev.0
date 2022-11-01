Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A36FA373D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Nov 2022 12:28:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N1q6k3kXsz3dvn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Nov 2022 23:27:58 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N1q5l3wCVz3f43
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2022 23:27:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4N1q5l2VvYz4x1H;
	Tue,  1 Nov 2022 23:27:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>, Rohan McLure <rmclure@linux.ibm.com>
In-Reply-To: <871qqoyvni.fsf_-_@igel.home>
References: <20220921065605.1051927-1-rmclure@linux.ibm.com> <20220921065605.1051927-10-rmclure@linux.ibm.com> <871qqoyvni.fsf_-_@igel.home>
Subject: Re: [PATCH] asm-generic: compat: fix compat_arg_u64 and compat_arg_u64_dual
Message-Id: <166730554860.2453885.422994462216856444.b4-ty@ellerman.id.au>
Date: Tue, 01 Nov 2022 23:25:48 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 31 Oct 2022 14:23:13 +0100, Andreas Schwab wrote:
> The macros are defined backwards.
> 
> 

Applied to powerpc/fixes.

[1/1] asm-generic: compat: fix compat_arg_u64 and compat_arg_u64_dual
      https://git.kernel.org/powerpc/c/40ff21432883216aa440b6619d559ad8f7d7a7d9

cheers
