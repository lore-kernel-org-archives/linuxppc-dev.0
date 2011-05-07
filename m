Return-Path: <richard.weinberger@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D7C8100811
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 May 2011 19:34:17 +1000 (EST)
Received: by qwf7 with SMTP id 7so2564793qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 May 2011 02:34:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Date: Sat, 7 May 2011 11:34:13 +0200
Message-ID: <BANLkTi=h-151_cMPpii6O+kowvc=0WxKjQ@mail.gmail.com>
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
From: richard -rw- weinberger <richard.weinberger@gmail.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, user-mode-linux-devel@lists.sourceforge.net,
	linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 7, 2011 at 7:57 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: x86@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
