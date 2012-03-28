Return-Path: <rientjes@google.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19AAEB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 18:20:38 +1100 (EST)
Received: by iakh37 with SMTP id h37so1138723iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:20:35 -0700 (PDT)
Date: Wed, 28 Mar 2012 00:20:32 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
In-Reply-To: <1332593574.16159.31.camel@twins>
Message-ID: <alpine.DEB.2.00.1203280020100.16201@chino.kir.corp.google.com>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Anton Vorontsov <anton.vorontsov@linaro.org>, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 24 Mar 2012, Peter Zijlstra wrote:

> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?
> 
> Fix sparse already instead of smearing ugly all over.
> 

Fully agreed, please don't add this to the oom killer.
