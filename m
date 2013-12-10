Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50AD92C03B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:49:08 +1100 (EST)
Date: Tue, 10 Dec 2013 23:48:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] KVM: PPC: Use schedule instead of cond_resched
Message-ID: <20131210224851.GH13532@twins.programming.kicks-ass.net>
References: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
 <1386708771.32037.73.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386708771.32037.73.camel@pasglop>
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

On Wed, Dec 11, 2013 at 07:52:51AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-12-10 at 15:40 +0100, Alexander Graf wrote:
> > On 10.12.2013, at 15:21, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> > 
> > > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > 
> > > We already checked need_resched. So we can call schedule directly
> > > 
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > The real fix for the issue you're seeing is
> > 
> >   https://lkml.org/lkml/2013/11/28/241
> > 
> 
> And is still not upstream.... Peter ?

Yeah, I went on holidays and the patch just sat there. I'll prod Ingo
into merging it.
