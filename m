Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1302B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2012 03:44:39 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id j10so3335324bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 09:44:39 -0700 (PDT)
Date: Sat, 24 Mar 2012 20:43:35 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
Message-ID: <20120324164335.GA4955@lizard>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
 <1332593303.16159.28.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1332593303.16159.28.camel@twins>
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
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

On Sat, Mar 24, 2012 at 01:48:23PM +0100, Peter Zijlstra wrote:
> On Sat, 2012-03-24 at 14:30 +0400, Anton Vorontsov wrote:
> > Traversing the tasks requires holding tasklist_lock, otherwise it
> > is unsafe. 
> 
> No it doesn't, it either requires tasklist_lock or rcu_read_lock().

Well, currently the code does neither. :-)

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
