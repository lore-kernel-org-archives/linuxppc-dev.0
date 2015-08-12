Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 005A71A1D30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 05:05:38 +1000 (AEST)
Subject: Re: [PATCH] kvm:powerpc:Fix incorrect return statement in the
 function mpic_set_default_irq_routing
To: Nicholas Krause <xerofoify@gmail.com>, gleb@kernel.org
References: <1438962893-3370-1-git-send-email-xerofoify@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <55CB98FE.4060908@suse.de>
Date: Wed, 12 Aug 2015 21:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <1438962893-3370-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07.08.15 17:54, Nicholas Krause wrote:
> This fixes the incorrect return statement in the function
> mpic_set_default_irq_routing from always returning zero
> to signal success to this function's caller to instead
> return the return value of kvm_set_irq_routing as this
> function can fail and we need to correctly signal the
> caller of mpic_set_default_irq_routing when the call
> to this particular function has failed.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

I like the patch, but I don't see it on the kvm-ppc mailing list. It
doesn't show up on patchwork or spinics. Did something go wrong while
sending it out?


Alex
