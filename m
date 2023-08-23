Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B859EE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:05:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4f961Pcz3dSg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:05:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cZ3dTfz2ytp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cY3vbjz4wy3;
	Wed, 23 Aug 2023 22:03:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20230809131024.2039647-1-arnd@kernel.org>
References: <20230809131024.2039647-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] powerpc: mark more local variables as volatile
Message-Id: <169279175547.797584.1233962438367558067.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Hugh Dickins <hughd@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Maninder Singh <maninder1.s@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 09 Aug 2023 15:10:08 +0200, Arnd Bergmann wrote:
> A while ago I created a2305e3de8193 ("powerpc: mark local variables
> around longjmp as volatile") in order to allow building powerpc with
> -Wextra enabled on gcc-11.
> 
> I tried this again with gcc-13 and found two more of the same issues,
> presumably based on slightly different optimization paths being taken
> here:
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: mark more local variables as volatile
      https://git.kernel.org/powerpc/c/0f7ce21ab5209426b00636636a5f2d9008738654
[2/2] powerpc: xmon: remove unused variables
      https://git.kernel.org/powerpc/c/ef73dcaa31217c79adc548bf9045afb40ac75b82

cheers
