Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBF07B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 21:57:20 +1000 (EST)
Received: by vws20 with SMTP id 20so2916471vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 04:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305973726-28006-1-git-send-email-dbaryshkov@gmail.com>
References: <1305973726-28006-1-git-send-email-dbaryshkov@gmail.com>
Date: Mon, 30 May 2011 15:57:17 +0400
Message-ID: <BANLkTikGyV8aG1twBt7Jt_=j-fSBDiGzAg@mail.gmail.com>
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: cpufreq@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 5/21/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
> boxes with all pmac-dependant features removed and simple cleanup
> applied.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/powerpc/kernel/misc_64.S          |    4 +-
>  arch/powerpc/platforms/Kconfig         |    8 +
>  arch/powerpc/platforms/maple/Makefile  |    1 +
>  arch/powerpc/platforms/maple/cpufreq.c |  317
> ++++++++++++++++++++++++++++++++
>  4 files changed, 328 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/maple/cpufreq.c

What about this patch?

-- 
With best wishes
Dmitry
