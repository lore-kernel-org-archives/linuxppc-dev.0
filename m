Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r45kQ1vbYzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 03:25:50 +1000 (AEST)
Subject: Re: [PATCH] kvm-pr: manage illegal instructions
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, Alexander Graf
 <agraf@suse.com>, Paul Mackerras <paulus@samba.org>
References: <1458073117-24652-1-git-send-email-lvivier@redhat.com>
 <57189C75.2060701@redhat.com> <573046F1.7070704@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57321995.20900@redhat.com>
Date: Tue, 10 May 2016 19:25:41 +0200
MIME-Version: 1.0
In-Reply-To: <573046F1.7070704@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/05/2016 10:14, Thomas Huth wrote:
>> > Tested-by: Thomas Huth <thuth@redhat.com>
> Ping!
> 
> Alex, Paul, could you please pick up this patch? This patch is required
> to get the kvm-unit-tests working properly with kvm-pr, so I'd be glad
> if we could get this included finally...

I have a pull request for 4.6 final to send tomorrow; do you want me to
include it?

Thanks,

Paolo
