Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 3B637DE044
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:38:40 +1000 (EST)
Received: by qyk34 with SMTP id 34so7025810qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 17:38:39 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090527002530.16740.62502.stgit@terra>
References: <20090527002530.16740.62502.stgit@terra>
Date: Tue, 26 May 2009 19:38:39 -0500
Message-ID: <ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 7:25 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> - =A0 =A0 =A0 spin_event_timeout(0, 10, 0, rc);
> + =A0 =A0 =A0 spin_event_timeout(0, 10, 0);
> =A0 =A0 =A0 =A0out_8(&regs->op0, MPC52xx_PSC_OP_RES);
> - =A0 =A0 =A0 spin_event_timeout(0, 50, 0, rc);
> + =A0 =A0 =A0 spin_event_timeout(0, 50, 0);

Jon, I'm still hoping you'll explain why you're not using udelay() here.

--=20
Timur Tabi
Linux kernel developer at Freescale
