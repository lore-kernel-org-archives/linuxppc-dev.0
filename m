Return-Path: <paulus@ozlabs.org>
Date: Thu, 3 Oct 2013 14:14:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Message-ID: <20131003041415.GA2801@iris.ozlabs.ibm.com>
References: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 02, 2013 at 08:08:44PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b

It's a good idea to give the headline of the commit as well as the ID.
I also like to trim the ID to 10 characters or so.  So it should look
like this:

This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
kvm_vcpu structs from kvm_vcpu_cache").

> arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>

Paul.
