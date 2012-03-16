Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7730EB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 03:20:55 +1100 (EST)
Subject: Re: [PATCH v3 3/4] powerpc: Move GE PIC drivers
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331572380-1064-4-git-send-email-martyn.welch@ge.com>
Date: Fri, 16 Mar 2012 11:13:55 -0500
Message-Id: <AF4135E9-8A86-4B17-8B6F-C7F9875FD8E7@kernel.crashing.org>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-4-git-send-email-martyn.welch@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2012, at 12:12 PM, Martyn Welch wrote:

> Move the GE PIC drivers to allow these to be used by non-86xx boards.
> 
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
> 
> v2: Move GPIO and PIC drivers to sysdev/ge/ rather than platforms/.
> 
> v3: Now just PIC driver. GPIO driver going to drivers/gpio.
> 
> arch/powerpc/platforms/86xx/Kconfig                |    4 ----
> arch/powerpc/platforms/86xx/Makefile               |    1 -
> arch/powerpc/platforms/86xx/gef_ppc9a.c            |    2 +-
> arch/powerpc/platforms/86xx/gef_sbc310.c           |    2 +-
> arch/powerpc/platforms/86xx/gef_sbc610.c           |    2 +-
> arch/powerpc/sysdev/Kconfig                        |    4 ++++
> arch/powerpc/sysdev/Makefile                       |    2 ++
> arch/powerpc/sysdev/ge/Makefile                    |    1 +
> .../86xx/gef_pic.c => sysdev/ge/ge_pic.c}          |    2 +-
> .../86xx/gef_pic.h => sysdev/ge/ge_pic.h}          |    0
> 10 files changed, 11 insertions(+), 9 deletions(-)
> create mode 100644 arch/powerpc/sysdev/ge/Makefile
> rename arch/powerpc/{platforms/86xx/gef_pic.c => sysdev/ge/ge_pic.c} (99%)
> rename arch/powerpc/{platforms/86xx/gef_pic.h => sysdev/ge/ge_pic.h} (100%)

applied

- k
