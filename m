Return-Path: <robert.jarzmik@free.fr>
Received: from smtp.smtpout.orange.fr (smtp13.smtpout.orange.fr
 [80.12.242.135])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk5n00m7rzDrVY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 02:26:11 +1000 (AEST)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Joe Perches <joe@perches.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Li Yang <leoli@freescale.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] usb: Convert pr_warning to pr_warn
References: <f86b512272987e0faeaccbe6466665175eaefe9a.1474992979.git.joe@perches.com>
Date: Tue, 27 Sep 2016 18:26:00 +0200
In-Reply-To: <f86b512272987e0faeaccbe6466665175eaefe9a.1474992979.git.joe@perches.com>
 (Joe Perches's message of "Tue, 27 Sep 2016 09:16:59 -0700")
Message-ID: <87d1jpb97r.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches <joe@perches.com> writes:

> Use the more common logging mechanism.
>
> Miscellanea:
>
> o Realign multiline statements
> o Coalesce format
>
> Signed-off-by: Joe Perches <joe@perches.com>
For pxa25x_udc.h:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
