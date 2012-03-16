Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3E34B6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 03:14:01 +1100 (EST)
Subject: Re: [PATCH v3 1/4] powerpc: Add GE FPGA config option
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331572380-1064-2-git-send-email-martyn.welch@ge.com>
Date: Fri, 16 Mar 2012 11:13:38 -0500
Message-Id: <1EB0BB40-016C-4082-9112-13A0EE0BAEB3@kernel.crashing.org>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-2-git-send-email-martyn.welch@ge.com>
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

> This patch adds the GE_FPGA configuration option. This is being carried
> out as ground work to allow the PIC and GPIO drivers to be move from the
> powerpc 86xx platform directory to more general locations to allow them to
> be used on non-86xx boards and to reduce churn when further boards using
> these drivers are added.
> 
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
> 
> v3: Broken out from patch moving PIC and GPIO drivers
> 
> arch/powerpc/platforms/86xx/Kconfig  |    7 +++++++
> arch/powerpc/platforms/86xx/Makefile |    7 ++++---
> drivers/watchdog/Kconfig             |    2 +-
> 3 files changed, 12 insertions(+), 4 deletions(-)

applied

- k
