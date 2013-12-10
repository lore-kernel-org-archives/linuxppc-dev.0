Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F201E2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:59:52 +1100 (EST)
Message-ID: <1386716350.32037.81.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: Use schedule instead of cond_resched
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 11 Dec 2013 09:59:10 +1100
In-Reply-To: <20131210224851.GH13532@twins.programming.kicks-ass.net>
References: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
 <1386708771.32037.73.camel@pasglop>
 <20131210224851.GH13532@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-10 at 23:48 +0100, Peter Zijlstra wrote:
> 
> Yeah, I went on holidays and the patch just sat there. I'll prod Ingo
> into merging it.

Thanks !

Cheers,
Ben.
