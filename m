Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 83E1BDDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:44:55 +1100 (EST)
Date: Thu, 4 Dec 2008 02:44:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/83xx: add support for MCU on 8349emitx,
	837xrdb and 8315erdb boards
Message-ID: <20081203234453.GA30813@oksana.dev.rtsoft.ru>
References: <20081017185709.GB30008@oksana.dev.rtsoft.ru>
	<ed82fe3e0812031510i5bb0745axb0c515c3d62e38d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <ed82fe3e0812031510i5bb0745axb0c515c3d62e38d8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2008 at 05:10:30PM -0600, Timur Tabi wrote:
> On Fri, Oct 17, 2008 at 12:57 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > MCU is an external Freescale MC9S08QG8 microcontroller, mainly used to
> > provide soft power-off function, but also exports two GPIOs (wired to
> > the LEDs and also available from the external headers).
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Kumar, I think you merged this patch incorrectly ...
[...]
> This node is supposed to go under the I2C node, but you put it under
> the DMA node.

I've noticed this on the other 'stg pull', when it told me that the
patch isn't empty (stg patch becomes empty if merged).

This should be fixed already:

http://ozlabs.org/pipermail/linuxppc-dev/2008-November/065666.html

Anyway, thanks for heads up!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
