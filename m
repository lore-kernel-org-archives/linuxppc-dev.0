Return-Path: <agraf@suse.de>
Message-ID: <4C447067.2030205@suse.de>
Date: Mon, 19 Jul 2010 17:33:59 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Make long relocations be ulong
References: <1279551293-32473-1-git-send-email-agraf@suse.de>
	<4C446FA0.8050403@redhat.com>
In-Reply-To: <4C446FA0.8050403@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Avi Kivity wrote:
> On 07/19/2010 05:54 PM, Alexander Graf wrote:
>> I'm not sure which tree this should go through. Avi and Ben, please
>> coordinate this.
>> ---
>>   arch/powerpc/include/asm/kvm_book3s.h |    4 ++--
>>   arch/powerpc/kvm/book3s_rmhandlers.S  |    4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>>    
>
> The diffstat suggests kvm.git.
>
> Is this broken in Linus' tree, or just kvm.git?

I got the bug report through linuxppc-dev, so I assume it's broken in
Linus' tree. In fact, that code has been around for a while already, so
it should even be in 2.6.24.

Alex
