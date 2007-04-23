Return-Path: <rsmadhvesh@vsnl.net>
Received: from fe2.vsnl.net (fe2.vsnl.net [203.200.235.172])
	by ozlabs.org (Postfix) with ESMTP id AF42BDDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 00:40:00 +1000 (EST)
Received: from vsnl.net ([172.16.28.40])
	by fe2.internal.vsnl.net (vsnl mail server fe2)
	with ESMTP id <0JGY000BTGKOJN60@fe2.internal.vsnl.net> for
	linuxppc-dev@ozlabs.org; Mon, 23 Apr 2007 20:06:25 +0530 (IST)
Date: Mon, 23 Apr 2007 19:36:24 +0500
From: rsmadhvesh@vsnl.net
Subject: Re: [RFC][PATCH]Kprobes for PPC32(BOOKE)
In-reply-to: <382B116B-1892-441F-9F4D-9E0F3F01FC92@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-id: <e38e8f4d2093d.462d0ab8@vsnl.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <e38bf5391d991.4628b0f3@vsnl.net>
	<382B116B-1892-441F-9F4D-9E0F3F01FC92@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, madhvesh.s@ap.sony.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Kumar Gala <galak@kernel.crashing.org> wrote on Saturday, April 21, 2007 1:04 am
> 
> On Apr 20, 2007, at 2:24 AM, rsmadhvesh@vsnl.net wrote:
> 
> > Hi Kumar,
> >
> > This is regarding the kprobes patches for
> > PPC32 BOOKE version. The attached patches
> > contain the implementation for this version.
> >
> > I saw your earlier postings and commits to 2.6.21
> > regarding kprobes for PPC32. Since the single
> > step mechanism in BookE is quite different, I
> > thought i can share some of the issues faced
> > in this implementation and get your review
> > feedback for those patches.
> 
> I'd love to review these patches.  Is there any possibility that I  
> could get you to build them for arch/powerpc on top of David 
> Gibson's  
> port of ebony to arch/powerpc.
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034483.html
> 
> I dont see much value in adding kprobes into arch/ppc and have been 
> 
> trying to push any 'new' functionality get added to arch/powerpc 
> and  
> only bug fixes to arch/ppc.
Thanks for taking interest in reviewing my patches.
I understand the recent discussions in merging ppc to
powerpc and now i can as well start merging my patches
to powerpc.  I will repost my patches after this, but if you find
any bugs in my code, please let me know.

-Madhvesh
