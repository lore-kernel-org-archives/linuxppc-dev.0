Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 05414DEBB4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 06:49:50 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so320175ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Jun 2008 13:49:48 -0700 (PDT)
Date: Tue, 3 Jun 2008 00:49:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/8] [WATCHDOG] mpc83xx_wdt: fix checkpatch issues
Message-ID: <20080602204943.GA7255@zarina>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080602173836.GA30705@polina.dev.rtsoft.ru>
	<20080602204318.4cb77070@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080602204318.4cb77070@core>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jochen@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 02, 2008 at 08:43:18PM +0100, Alan Cox wrote:
> On Mon, 2 Jun 2008 21:38:36 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > Quite tired of these warnings ;-), checkpatch spitting them when
> > seeing the rename patch.
> 
> I've already sent the maintainer a complete overhaul of watchdog via
> checkpatch.

Oh, I see it now, thanks. I've just read Wim's comments there, and I
think I'll have to wait for git-watchdog update and then will rebase my
work on top.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
