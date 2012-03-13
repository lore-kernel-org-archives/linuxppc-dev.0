Return-Path: <linus.walleij@linaro.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B23A3B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 22:51:54 +1100 (EST)
Received: by ghbg19 with SMTP id g19so425249ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 04:51:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1331572380-1064-5-git-send-email-martyn.welch@ge.com>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-5-git-send-email-martyn.welch@ge.com>
Date: Tue, 13 Mar 2012 12:51:51 +0100
Message-ID: <CACRpkdZv84PKts4jFscsNcOq6rggZXSYzu3CBe8NFDTPwsd1aw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc: Board support for GE IMP3A
From: Linus Walleij <linus.walleij@linaro.org>
To: Martyn Welch <martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
 =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2012 at 6:13 PM, Martyn Welch <martyn.welch@ge.com> wrote:

> Initial board support for the GE IMP3A, a 3U compactPCI card with a p2020
> processor.
(...)
> +++ b/arch/powerpc/configs/ge_imp3a_defconfig
> @@ -0,0 +1,257 @@
> +CONFIG_PPC_85xx=y
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=2
> +CONFIG_EXPERIMENTAL=y
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_BSD_PROCESS_ACCT=y
> +CONFIG_BSD_PROCESS_ACCT_V3=y
> +CONFIG_SPARSE_IRQ=y

This habit of changing a lot of defconfig stuff in a patch dealing with other
stuff is alien in the ARM world. Especially when changing a horde of stuff
that has nothing to do with the patch subject.

But I don't really know how PPC does these things so who am I to
speak ...

BTW: doesn't the "make saveconfig" reduce defconfigs on PPC?
Paging Uwe on this.

Yours,
Linus Walleij
