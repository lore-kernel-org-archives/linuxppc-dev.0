Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE5FC1A02AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 20:27:32 +1000 (EST)
Message-ID: <1401964037.3247.129.camel@pasglop>
Subject: Re: [PATCH 3/3] PPC: KVM: Add support for 64bit TCE windows
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 05 Jun 2014 20:27:17 +1000
In-Reply-To: <539037DB.5080706@ozlabs.ru>
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
 <1401953144-19186-4-git-send-email-aik@ozlabs.ru>
 <1401953908.3247.121.camel@pasglop> <539037DB.5080706@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-05 at 19:26 +1000, Alexey Kardashevskiy wrote:
> 
> No trees yet. For 64GB window we need (64<<30)/(16<<20)*8 = 32K TCE table.
> Do we really need trees?

The above is assuming hugetlbfs backed guests. These are the least of my worry
indeed. But we need to deal with 4k and 64k guests.

Cheers,
Ben
