Return-Path: <paulus@ozlabs.org>
Date: Fri, 4 Oct 2013 22:35:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Message-ID: <20131004123545.GC26884@iris.ozlabs.ibm.com>
References: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20131003041415.GA2801@iris.ozlabs.ibm.com>
 <EB193553-5B3C-4669-9C71-BACC6882D18B@suse.de>
 <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 04, 2013 at 02:27:02PM +0200, Alexander Graf wrote:
> 
> On 04.10.2013, at 14:23, Alexander Graf wrote:
> 
> > 
> > On 03.10.2013, at 06:14, Paul Mackerras wrote:
> > 
> >> On Wed, Oct 02, 2013 at 08:08:44PM +0530, Aneesh Kumar K.V wrote:
> >>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >>> 
> >>> This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b
> >> 
> >> It's a good idea to give the headline of the commit as well as the ID.
> >> I also like to trim the ID to 10 characters or so.  So it should look
> >> like this:
> >> 
> >> This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
> >> kvm_vcpu structs from kvm_vcpu_cache").
> >> 
> >>> arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
> >>> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
> >>> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
> >>> 
> >>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> Acked-by: Paul Mackerras <paulus@samba.org>
> > 
> > Would you guys mind if I merge this into the offending patch? It's not trickled into -next yet, so rebasing should work.
> > 
> > If not, please resend with the fixed commit message.
> 
> Eh - I must've missed v2 :). So that leaves only the question on whether you'd be ok to squash the patch instead. It'd help bisectability.

I'm OK with that.  If you do, why don't you squash the first of the
two patches that I just sent into the commit it fixes as well?

Paul.
