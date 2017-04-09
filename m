Return-Path: <chris@chris-wilson.co.uk>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1LJP2vxPzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 03:43:16 +1000 (AEST)
Date: Sun, 9 Apr 2017 18:26:31 +0100
From: Chris Wilson <chris@chris-wilson.co.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.11: Reported regressions as of Sunday, 2017-04-09
Message-ID: <20170409172631.GA6834@nuc-i3427.alporthouse.com>
References: <14254185-456f-4940-6a67-bc75d1eeb123@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14254185-456f-4940-6a67-bc75d1eeb123@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 09, 2017 at 07:15:49PM +0200, Thorsten Leemhuis wrote:
> Desc: i915 gpu hangs under load
> Repo: 2017-03-22 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg116227.html https://bugs.freedesktop.org/show_bug.cgi?id=100181 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
> Stat: 2017-04-07 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
> Note: A few patches from Andrea (who's seeing problems as well) are being discussed

Note, Andrea saw a completely different problem unrelated to the GPU
hang and date back to ~4.9. Both reported issues have been fixed, with
the earlier report already in mainline but Andrea's fix is not yet in a
PR.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
