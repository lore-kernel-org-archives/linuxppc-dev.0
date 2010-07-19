Return-Path: <avi@redhat.com>
Message-ID: <4C446FA0.8050403@redhat.com>
Date: Mon, 19 Jul 2010 18:30:40 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Make long relocations be ulong
References: <1279551293-32473-1-git-send-email-agraf@suse.de>
In-Reply-To: <1279551293-32473-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, subrata@linux.vnet.ibm.com, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/19/2010 05:54 PM, Alexander Graf wrote:
> I'm not sure which tree this should go through. Avi and Ben, please
> coordinate this.
> ---
>   arch/powerpc/include/asm/kvm_book3s.h |    4 ++--
>   arch/powerpc/kvm/book3s_rmhandlers.S  |    4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
>    

The diffstat suggests kvm.git.

Is this broken in Linus' tree, or just kvm.git?

-- 
error compiling committee.c: too many arguments to function
