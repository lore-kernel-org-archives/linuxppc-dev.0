Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEE77B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 00:58:22 +1000 (EST)
Message-ID: <4F956DF2.7020408@nod.at>
Date: Mon, 23 Apr 2012 16:57:54 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH 7/9] um: Should hold tasklist_lock while traversing
 processes
References: <20120423070641.GA27702@lizard> <20120423070925.GG30752@lizard>
In-Reply-To: <20120423070925.GG30752@lizard>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23.04.2012 09:09, Anton Vorontsov wrote:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe.
>
> p.s. However, I'm not sure that calling os_kill_ptraced_process()
> in the atomic context is correct. It seem to work, but please
> take a closer look.
>
> Signed-off-by: Anton Vorontsov<anton.vorontsov@linaro.org>
> ---

You forgot my Ack and I've already explained why 
os_kill_ptraced_process() is fine.

Thanks,
//richard
