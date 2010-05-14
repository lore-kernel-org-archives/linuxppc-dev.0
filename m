Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id 19516B7E88
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 16:03:30 +1000 (EST)
Date: Fri, 14 May 2010 15:02:40 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Peter H?we <PeterHuewe@gmx.de>
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Message-ID: <20100514060240.GD12002@linux-sh.org>
References: <201005051720.22617.PeterHuewe@gmx.de>
	<201005112042.14889.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201005112042.14889.PeterHuewe@gmx.de>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, David H?rdeman <david@hardeman.nu>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 11, 2010 at 08:42:14PM +0200, Peter H?we wrote:
> Am Mittwoch 05 Mai 2010 17:20:21 schrieb Peter H?we:
> > From: Peter Huewe <peterhuewe@gmx.de>
> > 
> > This patch adds a missing include linux/delay.h to prevent
> > build failures[1-5]
> > 
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> > ---
> Any updates on this patch?
> Issue still exists with today's linux-next tree
> 
You might want to send this to the linux-next list at least. If the
people who introduced the breakage are unresponsive (as often tends to be
the case with -next) it's still worth getting trivial fixes rolled in for
the interim. This change doesn't exist outside of -next and whatever tree
introduced it, so there's not much else anyone can do about it at
present.
