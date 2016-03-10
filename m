Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 7B99A1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 15:41:11 +1100 (AEDT)
Date: Thu, 10 Mar 2016 05:41:07 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kyle McMartin <kyle@mcmartin.ca>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/6] rtc: generic: follow up for COMPILE_TEST
Message-ID: <20160310044107.GD9868@piout.net>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 01/03/2016 at 17:59:56 +0100, Arnd Bergmann wrote :
> Today's linux-next kernel allowed building the rtc-generic
> driver (and most other rtc drivers) on all architectures,
> but this caused some errors on architectures without asm/rtc.h.
> 
> This series reworks that driver to avoid the dependency,
> and simplifies all four implementations. My first approach
> was to split the driver into four separate drivers, but
> that didn't feel right when three of them have their own
> multiplexors.
> 
> The first five patches can be applied independent of one other,
> while patch 6 is optional and can be applied when all others
> are merged. Alternatively, they can all go in through the
> rtc tree. I compile-tested only the powerpc and sh targets for
> which I happened to have cross-compilers installed.
> 

I like this approach. Maybe you can also remove the now unnecessary
definitions from the various asm/rtc.h.

I have a small nitpick on the parisc patch.

I'll take the first patch, no need to resend that one.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
