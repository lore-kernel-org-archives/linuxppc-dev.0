Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA56C67A62
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 07:42:38 +1000 (EST)
In-Reply-To: <1145900516.4251.18.camel@cashmere.sps.mot.com>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Mon, 24 Apr 2006 16:43:14 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2006, at 12:41 PM, Jon Loeliger wrote:

> OK, so what is the deal with the 85xx patches
> that have been submitted for more FDT support?
> I get a variety of mixed stories, message and
> vague comments.  I want some facts and direction.
>
> Can anyone verify, validate, refute, deny or
> support any of these statements?  Not trying to
> be mean, point fingers or sound negative here,
> I'm just trying to pinpoint the apparent log-jam.
>
>
> 1. The 85xx patches that Andy submitted, that
>    have been pulled into Kumar's 85xx git tree
>    are going to sit there until further patches
>    are submitted that _remove_all_85xx_support_
>    from the arch/ppc tree as well.
>
> 2. The same patches are going to sit in Kumar's
>    tree until 8560 patches with support for CPM
>    are released and all 85xx ports appear fully
>    and completely in arch/powerpc.  BTW, CPM is
>    waiting on approval of Vitaly's CPM proposal
>    for OF FDT support.
>
> 3. Statements 1 and 2 combined.
>
> 4. The same 85xx patches have just slipped through
>    some mental crack and simply need to be pulled,
>    re-applied, re-drafted, re-submitted.  Oops, sorry.
>    The action item is in _________'s lap.
>
> 5. There was an unresolved comment/issue that
>    FSL still needs to address.  BTW, that issue
>    is ________.
>
> 6. We are waiting on something else and that
>    item is _______.
>
> 7. You know, you really need to address the _other_
>    85xx ports (such as TQMs) as well.  Can you
>    please do something about those as well?
>
> 8. These Linux patches aren't going to be picked
>    up until the corresponding U-Boot patches are
>    picked up as well.

My understanding is that paulus should pull them into powerpc.git.   
He hasn't given me any reason to believe that shouldn't just happen.   
I dont see any reason that we need to have other dependancies for  
code that works.  I'll push on paulus to pull the patches in my tree  
into powerpc.git.

However, I am against removing the arch/ppc support until the u-boot  
patches are picked up.  I think its bad form to give people a kernel  
they can't easily boot.

- k
