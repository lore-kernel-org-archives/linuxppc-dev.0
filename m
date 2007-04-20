Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 116DADDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 05:33:46 +1000 (EST)
In-Reply-To: <e38bf5391d991.4628b0f3@vsnl.net>
References: <e38bf5391d991.4628b0f3@vsnl.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <382B116B-1892-441F-9F4D-9E0F3F01FC92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH]Kprobes for PPC32(BOOKE)
Date: Fri, 20 Apr 2007 14:33:41 -0500
To: rsmadhvesh@vsnl.net
Cc: linuxppc-dev@ozlabs.org, madhvesh.s@ap.sony.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2007, at 2:24 AM, rsmadhvesh@vsnl.net wrote:

> Hi Kumar,
>
> This is regarding the kprobes patches for
> PPC32 BOOKE version. The attached patches
> contain the implementation for this version.
>
> I saw your earlier postings and commits to 2.6.21
> regarding kprobes for PPC32. Since the single
> step mechanism in BookE is quite different, I
> thought i can share some of the issues faced
> in this implementation and get your review
> feedback for those patches.

I'd love to review these patches.  Is there any possibility that I  
could get you to build them for arch/powerpc on top of David Gibson's  
port of ebony to arch/powerpc.

http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034483.html

I dont see much value in adding kprobes into arch/ppc and have been  
trying to push any 'new' functionality get added to arch/powerpc and  
only bug fixes to arch/ppc.

- k
