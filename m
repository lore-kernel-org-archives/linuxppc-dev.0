Return-Path: <avi@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C3297B7314
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:04:26 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 3CE0DDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:04:25 +1000 (EST)
Message-ID: <4A38F7DC.3030206@redhat.com>
Date: Wed, 17 Jun 2009 17:04:12 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: kvm/powerpc tree build failure
References: <20090617150419.e406a69a.sfr@canb.auug.org.au>	<4A38F47F.509@redhat.com>
	<20090617235546.95aa39a5.sfr@canb.auug.org.au>
In-Reply-To: <20090617235546.95aa39a5.sfr@canb.auug.org.au>
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

On 06/17/2009 04:55 PM, Stephen Rothwell wrote:
> Hi Avi,
>
> On Wed, 17 Jun 2009 16:49:51 +0300 Avi Kivity<avi@redhat.com>  wrote:
>    
>> Thanks, applied.  For some reason my own build testing didn't fail on this.
>>      
>
> Thanks.  It could be a different compiler version doesn't complain (I am
> currently using 4.4.0) and the powerpc tree has a patch to build parts of
> arch/powerpc with -Werror which makes it stand out a bit :-)
>    

Ah yes, you did mention it was a warning.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
