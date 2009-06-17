Return-Path: <avi@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B34CB719C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 23:50:08 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id A8C98DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 23:50:07 +1000 (EST)
Message-ID: <4A38F47F.509@redhat.com>
Date: Wed, 17 Jun 2009 16:49:51 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: kvm/powerpc tree build failure
References: <20090617150419.e406a69a.sfr@canb.auug.org.au>
In-Reply-To: <20090617150419.e406a69a.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2009 08:04 AM, Stephen Rothwell wrote:
> From: Stephen Rothwell<sfr@canb.auug.org.au>
> Date: Wed, 17 Jun 2009 14:57:29 +1000
> Subject: [PATCH] kvm/powerpc: make 32 bit constant unsigned long
>
> KVM_PAGES_PER_HPAGE needs to be unsigned long since its value is 2^31.
>
> Eliminates this compiler warning:
>
>    

Thanks, applied.  For some reason my own build testing didn't fail on this.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
