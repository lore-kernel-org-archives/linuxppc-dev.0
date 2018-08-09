Return-Path: <kvalo@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mg4W2yFlzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 06:35:38 +1000 (AEST)
From: Kalle Valo <kvalo@codeaurora.org>
To: Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 b43-dev <b43-dev@lists.infradead.org>, Joe Perches <joe@perches.com>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG
References: <20180731221509.59c0a17a@wiggum>
Date: Thu, 09 Aug 2018 18:49:02 +0300
In-Reply-To: <20180731221509.59c0a17a@wiggum> ("Michael
 \=\?utf-8\?Q\?B\=C3\=BCs\?\= \=\?utf-8\?Q\?ch\=22's\?\= message of
 "Tue, 31 Jul 2018 22:15:09 +0200")
Message-ID: <8736vn1qxd.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael B=C3=BCsch <m@bues.ch> writes:

> Use the standard WARN_ON instead.
> If a small kernel is desired, WARN_ON can be disabled globally.
>
> Also remove SSB_DEBUG. Besides WARN_ON it only adds a tiny debug check.
> Include this check unconditionally.
>
> Signed-off-by: Michael Buesch <m@bues.ch>

Applied manually:

209b43759d65 ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG

--=20
Kalle Valo
