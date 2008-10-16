Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56BA9DDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 08:17:48 +1100 (EST)
Date: Thu, 16 Oct 2008 14:17:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
Message-Id: <20081016141729.1f6550f0.akpm@linux-foundation.org>
In-Reply-To: <1223997906-19900-1-git-send-email-agust@denx.de>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dmitry, linux-fbdev-devel@lists.sourceforge.net,
	Baryshkov <dbaryshkov@gmail.com>,
	Matteo Fortini <m.fortini@selcomgroup.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Oct 2008 17:25:06 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> This patch adds framebuffer driver for Fujitsu
> Carmine/Coral-P(A)/Lime graphics controllers.
> Lime GDC support is known to work on PPC440EPx
> based lwmon5 and MPC8544E based socrates embedded
> boards, both equipped with Lime GDC. Carmine/Coral-P
> PCI GDC support is known to work on PPC440EPx based
> Sequoia board and also on x86 platform.

Well I've read all the followup discussion and now I don't know what
to do.

I think I'll just merge it and see if anyone shouts at me.
