Return-Path: <jwboyer@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id 9ACB3DDFB1
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 00:17:59 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so199207ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 05:17:57 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 30 Jan 2009 08:16:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Madhulika Madishetty <mmadishetty@amcc.com>
Subject: Re: [PATCH 1/1 v2] AMCC PPC 460SX redwood SoC platform initial
	framework
Message-ID: <20090130131601.GA2784@yoda.jdub.homelinux.org>
References: <AC5E1C3367E37D44970B81A6ADD1DA2C06C31EE8@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C06C31EE8@SDCEXCHANGE01.ad.amcc.com>
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org, Loc Ho <lho@amcc.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 29, 2009 at 01:05:08PM -0800, Madhulika Madishetty wrote:
> 
>Resubmitting patch without the confidentiality notice.
>
>From: Madhulika Madishetty <mmadishetty@amcc.com>
>
>This patch contains initial framework for the AMCC Redwood board.
>
>Signed-off-by: Madhulika Madishetty <mmadishetty@amcc.com>
>Signed-off-by: Tirumala Marri <tmarri@amcc.com>
>Signed-off-by: Feng Kan <fkan@amcc.com>
>Signed-off-by: Vidhyananth Venkatasamy <vvenkatasamy@amcc.com>
>Signed-off-by: Preetesh Parekh <pparekh@amcc.com>
>Acked-by: Loc Ho <lho@amcc.com>
>Acked-by: Feng Kan <fkan@amcc.com>
>---
> arch/powerpc/boot/dts/redwood.dts          |  245 ++++++
> arch/powerpc/configs/44x/redwood_defconfig | 1174
>++++++++++++++++++++++++++++
> arch/powerpc/kernel/cpu_setup_44x.S        |    1 +
> arch/powerpc/kernel/cputable.c             |   13 +
> arch/powerpc/platforms/44x/Kconfig         |   19 +
> arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
> 6 files changed, 1453 insertions(+), 0 deletions(-)  create mode 100644
>arch/powerpc/boot/dts/redwood.dts  create mode 100644
>arch/powerpc/configs/44x/redwood_defconfig

>From a code perspective, this looks much improved from the last time it was
submitted.  Good job there.

However, the patch itself appears to be word-wrapped or otherwise corrupted:

[jwboyer@yoda linux-2.6]$ git am -i ~/Download/1-1-v2-AMCC-PPC-460SX-redwood-SoC-platform-initial-framework.patch
Applying AMCC PPC 460SX redwood SoC platform initial framework
fatal: corrupt patch at line 55
Patch failed at 0001.

You need to teach your email program (or mail server perhaps) to not do that.

josh
