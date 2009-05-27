Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 7C821DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 21:39:56 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2331974qwe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:39:54 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090527043018.4667.94590.stgit@terra>
References: <20090527043018.4667.94590.stgit@terra>
Date: Wed, 27 May 2009 06:39:54 -0500
Message-ID: <ed82fe3e0905270439h4a068564keeb6c0905e958d2a@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2] Modify mpc5200 AC97 driver to use V9 of
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

On Tue, May 26, 2009 at 11:30 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The function signature for spin_event_timeout() has changed in version V9.
> Adjust the mpc5200 AC97 driver to use the new function.
> v2 - switch back to udelay() for fixed timeouts.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
