Return-Path: <avi@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 61DA4DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 19:59:22 +1000 (EST)
Message-ID: <4A24F772.8070904@redhat.com>
Date: Tue, 02 Jun 2009 12:57:06 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/kvm: fix some init/exit annotations
References: <20090602114614.50f8f0dd.sfr@canb.auug.org.au>
In-Reply-To: <20090602114614.50f8f0dd.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Liu Yu <yu.liu@freescale.com>, Hollis Blanchard <hollisb@us.ibm.com>,
	kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Fixes a couple of warnings like this one:
>
> WARNING: arch/powerpc/kvm/kvm-440.o(.text+0x1e8c): Section mismatch in reference from the function kvmppc_44x_exit() to the function .exit.text:kvmppc_booke_exit()
> The function kvmppc_44x_exit() references a function in an exit section.
> Often the function kvmppc_booke_exit() has valid usage outside the exit section
> and the fix is to remove the __exit annotation of kvmppc_booke_exit.
>   

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
