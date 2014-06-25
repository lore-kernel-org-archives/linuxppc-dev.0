Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by lists.ozlabs.org (Postfix) with ESMTP id 5DFF91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 06:04:29 +1000 (EST)
Date: Wed, 25 Jun 2014 13:04:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
Message-Id: <20140625130425.609ad4293781f5ac81772bf9@linux-foundation.org>
In-Reply-To: <53AAC1B4.5000204@samsung.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
 <20140617012507.GA6825@js1304-P5Q-DELUXE>
 <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
 <53AAC1B4.5000204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 Jun 2014 14:33:56 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > That's probably easier.  Marek, I'll merge these into -mm (and hence
> > -next and git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git)
> > and shall hold them pending you review/ack/test/etc, OK?
> 
> Ok. I've tested them and they work fine. I'm sorry that you had to wait for
> me for a few days. You can now add:
> 
> Acked-and-tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks.

> I've also rebased my pending patches onto this set (I will send them soon).
> 
> The question is now if you want to keep the discussed patches in your 
> -mm tree,
> or should I take them to my -next branch. If you like to keep them, I assume
> you will also take the patches which depends on the discussed changes.

Yup, that works.
