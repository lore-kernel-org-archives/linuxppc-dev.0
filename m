Return-Path: <ktdann@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.196])
	by ozlabs.org (Postfix) with ESMTP id 7FAB767B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 14:47:22 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so96325rnf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 21:47:21 -0700 (PDT)
Message-ID: <9b7ca65705041221402e23543@mail.gmail.com>
Date: Wed, 13 Apr 2005 13:40:41 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Daniel Ann <ktdann@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050412135114.GB27920@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412122405.GA27920@tuxdriver.com>
	<9b7ca657050412060556af952e@mail.gmail.com>
	<20050412135114.GB27920@tuxdriver.com>
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

On 4/12/05, John W. Linville <linville@tuxdriver.com> wrote:
> My guess would be that your best bet is to move your call to
> notifier_call_chain off to a workqueue.  notifier_call_chain (and/or
> one or more of the functions it is calling) is likely written to
> expect to be in process context.

I was thinking that this might have something to do with BH stuff that
I've left out from reading. (rather complicated :P)
Forgive me for trying to take an easy way, but moving things to
workqueue, do you mean putting it in bottom half? (Im sorta guessing
bottom half is like something you do after finishing high priority
tasks)

(I guess you had this coming) How do you move it to the workqueue?

--=20
Daniel
