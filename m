Return-Path: <segooon@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 73D07B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 23:32:15 +1000 (EST)
Received: by ewy21 with SMTP id 21so2636229ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 06:32:12 -0700 (PDT)
Date: Mon, 13 Sep 2010 17:32:08 +0400
From: Vasiliy Kulikov <segooon@gmail.com>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] char: hvc: check for error case
Message-ID: <20100913133208.GA11032@albatros>
References: <1284317835-5086-1-git-send-email-segooon@gmail.com>
	<4C8E2355.60807@tilera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C8E2355.60807@tilera.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 13, 2010 at 09:12 -0400, Chris Metcalf wrote:
> Thanks, accepted into my tree (for the next merge window).  In practice all
> this means is in debug mode we'll get a warning from do_one_initcall()
> rather than silence, but you're right, it's technically better. :-)

Anyway it's better, if user sees warning in the dmesg, he/she might
response to this situation.


Best,
-- 
Vasiliy
