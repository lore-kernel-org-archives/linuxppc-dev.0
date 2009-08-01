Return-Path: <timur.tabi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A7FAAB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 22:25:28 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id CC914DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2009 22:25:26 +1000 (EST)
Received: by fxm22 with SMTP id 22so1888753fxm.9
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Aug 2009 05:25:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <Pine.LNX.4.64.0908011052290.23408@ask.diku.dk>
References: <Pine.LNX.4.64.0908011052290.23408@ask.diku.dk>
Date: Sat, 1 Aug 2009 07:25:24 -0500
Message-ID: <ed82fe3e0908010525w56e93f6cl1d4c1bcc84d9e014@mail.gmail.com>
Subject: Re: [PATCH 1/10] arch/powerpc/sysdev/qe_lib: introduce missing kfree
From: Timur Tabi <timur@freescale.com>
To: Julia Lawall <julia@diku.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 1, 2009 at 3:52 AM, Julia Lawall<julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
>
> Error handling code following a kzalloc should free the allocated data.
>

...

>
> Signed-off-by: Julia Lawall <julia@diku.dk>
> ---
> =A0arch/powerpc/sysdev/qe_lib/qe_ic.c =A0| =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale
