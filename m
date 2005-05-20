Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id A230B679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 04:12:56 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so986014wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 11:12:54 -0700 (PDT)
Message-ID: <c3d0340b050520111228a6f4cd@mail.gmail.com>
Date: Fri, 20 May 2005 11:12:54 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050519020953.GB11587@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050518175411c484e3@mail.gmail.com>
	<20050519012404.GA11587@gate.ebshome.net>
	<c3d0340b05051818524c647e61@mail.gmail.com>
	<20050519020953.GB11587@gate.ebshome.net>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> My recommendation - don't do this. Why do you need to allocate this
> big chunk of consistent memory in the first place? You can do DMA
> _without_ allocating "consistent" memory. In fact, this is how
> virtually all devices work in Linux. For more info about DMA API -
> look at Documentation/DMA-API.txt.

The driver stack we've been developing (already 4.0) uses consistent
memory a lot for DMA. The stack is for many kinds of high performance
storage IO e.g. iSCSI, FC. It works fine on 2.4.x because there is no
such 2MB consistent pool limitation.

> Technically, you can make consistent pool bigger, if you really insist
> on using this approach.

I want to understand the motivation and the rationale of choosing
'consistent_pte' on 2.6.x, what impact there would be to increase the
consistent pool, and so on. Some pointers to articles, posts are more
helpful.

Thanks a lot,
-Shawn.
