Return-Path: <mj.embd@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 3A12BB7BFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 19:39:52 +1100 (EST)
Received: by wyf23 with SMTP id 23so3129049wyf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 01:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1269417391.8599.188.camel@pasglop>
References: <1269417391.8599.188.camel@pasglop>
Date: Thu, 25 Mar 2010 14:09:49 +0530
Message-ID: <62fe9ccc1003250139m7e8fecf9g2976a1bc244f6aa5@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: Export purge_vmap_area_lazy()
From: MJ embd <mj.embd@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nick Piggin <npiggin@suse.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 24, 2010 at 1:26 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some powerpc code needs to ensure that all previous iounmap/vunmap has
> really been flushed out of the MMU hash table. Without that, various
> hotplug operations may fail when trying to return those pieces to
> the hypervisor due to existing active mappings.
Are you talking about KVM or any other hypervisor ?
