Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74C58B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 17:54:40 +1000 (EST)
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1937BDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 17:54:37 +1000 (EST)
Message-ID: <4A6EAEC8.7030103@gefanuc.com>
Date: Tue, 28 Jul 2009 08:54:48 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: "next" branch update
References: <1248754493.30993.47.camel@pasglop>
In-Reply-To: <1248754493.30993.47.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> So I opened powerpc-next, and pushed the pile that was in "test" (with
> an additional bug fix to one of my patches that was causing the crash
> at boot that mpe reported with hugetlbfs enabled).
>
> The pre-req patch for adding an argument to __pte_free_tlb() has already
> been merged upstream by Linus.
>
> Now is time for people who want things into 2.6.32 to be noisy about it.
>   
Hi Ben,

I'd like to get the NVRAM patches into 2.6.32, I know you said to pester 
you in a week but your asking now :-) :

http://patchwork.ozlabs.org/patch/29420/
http://patchwork.ozlabs.org/patch/29422/
http://patchwork.ozlabs.org/patch/29421/
http://patchwork.ozlabs.org/patch/29419/
http://patchwork.ozlabs.org/patch/29418/

There's also some updates to the boards I work on:

http://patchwork.ozlabs.org/patch/29404/
http://patchwork.ozlabs.org/patch/29403/
http://patchwork.ozlabs.org/patch/29402/
http://patchwork.ozlabs.org/patch/29335/
http://patchwork.ozlabs.org/patch/29332/

Kumar: have you had a chance to look at these / are you happy with them?

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
