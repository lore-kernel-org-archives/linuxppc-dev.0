Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 583902C0343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 10:08:44 +1100 (EST)
Message-ID: <1386708771.32037.73.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: Use schedule instead of cond_resched
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 11 Dec 2013 07:52:51 +1100
In-Reply-To: <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
References: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
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

On Tue, 2013-12-10 at 15:40 +0100, Alexander Graf wrote:
> On 10.12.2013, at 15:21, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > We already checked need_resched. So we can call schedule directly
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> The real fix for the issue you're seeing is
> 
>   https://lkml.org/lkml/2013/11/28/241
> 

And is still not upstream.... Peter ?

Cheers,
Ben.
