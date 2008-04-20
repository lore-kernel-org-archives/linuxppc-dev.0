Return-Path: <avi@qumranet.com>
Received: from il.qumranet.com (bzq-179-150-194.static.bezeqint.net
	[212.179.150.194]) by ozlabs.org (Postfix) with ESMTP id 01FA1DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 17:38:54 +1000 (EST)
Message-ID: <480AF233.6020804@qumranet.com>
Date: Sun, 20 Apr 2008 10:35:15 +0300
From: Avi Kivity <avi@qumranet.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] [POWERPC KVM] Kconfig fixes
References: <a607ae1a7c8c4d674678.1208447016@localhost.localdomain>
In-Reply-To: <a607ae1a7c8c4d674678.1208447016@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-devel@lists.sourceforge.net, kvm-ppc-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> 1 file changed, 5 insertions(+), 6 deletions(-)
> arch/powerpc/kvm/Kconfig |   11 +++++------
>
>
> Don't allow building as a module (asm-offsets dependencies).
>
> Also, automatically select KVM_BOOKE_HOST until we better separate the guest
> and host layers.
>
>   

Applied, thanks.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
