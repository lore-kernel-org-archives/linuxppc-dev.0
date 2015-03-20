Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AC131A2A8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 22:41:28 +1100 (AEDT)
Message-ID: <550C0760.50903@suse.de>
Date: Fri, 20 Mar 2015 12:41:20 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Arseny Solokha <asolokha@kb.kras.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] kvm/ppc/mpic: drop unused IRQ_testbit
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-3-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1426823789-949-3-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset=windows-1252
Cc: Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20.03.15 04:56, Arseny Solokha wrote:
> Drop unused static procedure which doesn't have callers within its
> translation unit. It had been already removed independently in QEMU[1]
> from the OpenPIC implementation borrowed from the kernel.

The order was reverse. QEMU's implementation was first and then got
imported into the kernel.

> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2014-06/msg01812.html
> 
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>

Please resubmit the patch with CC on kvm@vger and kvm-ppc@vger.


Alex
