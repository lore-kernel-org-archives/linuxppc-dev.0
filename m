Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469AC3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 12:58:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSZ2g6qlPz3g3V
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 23:58:19 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYs16g5gz3bhn
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:49:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYs021q9z4xvd;
	Thu,  8 Dec 2022 23:49:56 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Jeanson <mjeanson@efficios.com>
In-Reply-To: <20221201161442.2127231-1-mjeanson@efficios.com>
References: <20221201161442.2127231-1-mjeanson@efficios.com>
Subject: Re: [PATCH] powerpc/ftrace: fix syscall tracing on PPC64_ELF_ABI_V1
Message-Id: <167050321063.1457988.11365233998356574445.b4-ty@ellerman.id.au>
Date: Thu, 08 Dec 2022 23:40:10 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 1 Dec 2022 11:14:42 -0500, Michael Jeanson wrote:
> In v5.7 the powerpc syscall entry/exit logic was rewritten in C, on
> PPC64_ELF_ABI_V1 this resulted in the symbols in the syscall table
> changing from their dot prefixed variant to the non-prefixed ones.
> 
> Since ftrace prefixes a dot to the syscall names when matching them to
> build its syscall event list, this resulted in no syscall events being
> available.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ftrace: fix syscall tracing on PPC64_ELF_ABI_V1
      https://git.kernel.org/powerpc/c/ad050d2390fccb22aa3e6f65e11757ce7a5a7ca5

cheers
