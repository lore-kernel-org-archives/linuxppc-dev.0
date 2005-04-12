Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 7B16A67B1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 18:50:01 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1441155wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 01:49:59 -0700 (PDT)
Message-ID: <9b7ca657050412014971db02a7@mail.gmail.com>
Date: Tue, 12 Apr 2005 17:49:59 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <9b7ca6570504120138738b554f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
Subject: Re: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In addition,

Im running 2.4.21 kernel.

Just then, I was looking at the 2.6.11 kernel source
(net/core/skbuff.c) and found out that large chunk of the alloc_skb()
has been thrown out.

Can this be removed from 2.4.21 also ? I might go and check out why
its been removed.

Still waiting for some good answer tho .. :)

Cheers,


On Apr 12, 2005 5:38 PM, Daniel Ann <ktdann@gmail.com> wrote:
> Hiya folks,
> 
> I'm wondering if anyone could help me out with problem I have in alloc_skb().
> 
> My problem is that, kernel dies with "alloc_skb called nonatomically
> from interrupt c00ba718" message. After browsing mailing list, I think
> its to do with not providing it with enough locks prior.
> 
> Question is, what kind of lock should I be providing ?
> 
> Since I have no clue as to which lock does what, I really need some
> good advise as to where to start looking.
> 
> Could someone tell me the inside story on this ?
> 
> --
> Daniel
> 


-- 
Daniel
