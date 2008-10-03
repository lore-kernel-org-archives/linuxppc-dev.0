Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 40772DDFA4
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:54:45 +1000 (EST)
Received: by gxk14 with SMTP id 14so3506281gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 09:54:44 -0700 (PDT)
Message-ID: <ed82fe3e0810030954r8f218c1q1f1cd451fcfbc5e1@mail.gmail.com>
Date: Fri, 3 Oct 2008 11:54:43 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: avorontsov@ru.mvista.com, "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable Kconfig
	option
In-Reply-To: <20081003162317.GA31740@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
	<48E643A5.9060403@freescale.com>
	<20081003162317.GA31740@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 3, 2008 at 11:23 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> How about this patch? Or we can move QUICC_ENGINE into the
> qe_lib/Kconfig and include it in the platform/Kconfig... either
> way would work.
>
> Thanks for noticing.
>
>  arch/powerpc/Kconfig               |    2 --
>  arch/powerpc/platforms/Kconfig     |   36 ++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/qe_lib/Kconfig |   35 -----------------------------------
>  3 files changed, 36 insertions(+), 37 deletions(-)
>  delete mode 100644 arch/powerpc/sysdev/qe_lib/Kconfig

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
