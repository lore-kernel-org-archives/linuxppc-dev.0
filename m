Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D2CBB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 10:59:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACF9ADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 10:59:19 +1000 (EST)
Message-Id: <74BA64FD-0DFF-45A2-868D-A001D9BA496F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248310415.3367.22.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te, ud,
	md}_free_tlb()
Date: Wed, 22 Jul 2009 19:59:08 -0500
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1248073873.13067.31.camel@pasglop>
	<alpine.LFD.2.01.0907220930320.19335@localhost.localdomain>
	<1248310415.3367.22.camel@pasglop>
Cc: Nick Piggin <npiggin@suse.de>, Linux-Arch <linux-arch@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@tiscali.co.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2009, at 7:53 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2009-07-22 at 09:31 -0700, Linus Torvalds wrote:
>>> CC'ing Linus here. How do you want to proceed with that merge ?  
>>> (IE. so
>>> far nobody objected to the patch itself)
>>
>> Maybe you can put it as a separate branch in -next, and have it  
>> merged
>> before the stuff that depends on it, and then just sending it to me  
>> (as a
>> git branch or patch or whatever) in the first day of the merge  
>> window?
>
> Hrm... my powerpc-next branch will contain stuff that depend on it, so
> I'll probably have to pull it in though, unless I tell all my
> sub-maintainers to also pull from that other branch first :-)

Can you not cherry pick it into powerpc-next to 'pull it through'?

- k
