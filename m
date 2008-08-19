Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 061CADDFD1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:23:42 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so92538pyi.27
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 14:23:40 -0700 (PDT)
Message-ID: <9e4733910808191423u34946955lc85caa6b2217b390@mail.gmail.com>
Date: Tue, 19 Aug 2008 17:23:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] rtc: rtc-ds1374: fix 'no irq' case handling
In-Reply-To: <20080819212937.01dfd024@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080812161733.GA32164@oksana.dev.rtsoft.ru>
	<9e4733910808191339s28a05f90pef57961e8d24fbdb@mail.gmail.com>
	<20080819212937.01dfd024@lxorguk.ukuu.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/19/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Shouldn't this be
>  >
>  > >  -       if (client->irq <= NO_IRQ)
>  >
>  > instead of
>
>
> NO_IRQ is obsolete. client->irq != is the test and IRQ numbers are
>  unsigned.

I don't know the status of these platforms....

asm-blackfin/irq.h:#define NO_IRQ ((unsigned int)(-1))
asm-mn10300/irq.h:#define NO_IRQ		INT_MAX
asm-parisc/irq.h:#define NO_IRQ		(-1)

-- 
Jon Smirl
jonsmirl@gmail.com
