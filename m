Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26208B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 01:41:48 +1000 (EST)
Received: by yhnn12 with SMTP id n12so6560797yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 08:41:45 -0700 (PDT)
Date: Mon, 23 Apr 2012 08:40:27 -0700
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 7/9] um: Should hold tasklist_lock while traversing
 processes
Message-ID: <20120423154027.GA23066@lizard>
References: <20120423070641.GA27702@lizard> <20120423070925.GG30752@lizard>
 <4F956DF2.7020408@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4F956DF2.7020408@nod.at>
Cc: linaro-kernel@lists.linaro.org, Mike Frysinger <vapier@gentoo.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 patches@linaro.org, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 uclinux-dist-devel@blackfin.uclinux.org, Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2012 at 04:57:54PM +0200, Richard Weinberger wrote:
> On 23.04.2012 09:09, Anton Vorontsov wrote:
> >Traversing the tasks requires holding tasklist_lock, otherwise it
> >is unsafe.
> >
> >p.s. However, I'm not sure that calling os_kill_ptraced_process()
> >in the atomic context is correct. It seem to work, but please
> >take a closer look.
> >
> >Signed-off-by: Anton Vorontsov<anton.vorontsov@linaro.org>
> >---
> 
> You forgot my Ack and I've already explained why
> os_kill_ptraced_process() is fine.

Ouch, sorry!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
