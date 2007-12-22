Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 52233DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:26:50 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so869059fkz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 16:26:49 -0800 (PST)
Date: Sat, 22 Dec 2007 03:16:26 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
Message-ID: <20071222001626.GA1130@zarina>
References: <20071221202824.GA4607@localhost.localdomain>
	<fa686aa40712211250l2645d34dr45c5be2bf1c9006d@mail.gmail.com>
	<20071221210445.GA5190@localhost.localdomain>
	<fa686aa40712211317o401be150n32196a25b5ab1481@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40712211317o401be150n32196a25b5ab1481@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 02:17:57PM -0700, Grant Likely wrote:
> On 12/21/07, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > As I've probably said once already: if there are plans to build single
> > kernel with QE+CPM1+CPM2 inside tomorrow -- then of course, I'd better
> > wait.
> >
> > But if these plans are distant enough, I see no reason why we can't
> > enjoy of current API.
> 
> Oh, I'm not saying don't enjoy it.  :-)  I'm just saying keep it out
> of mainline.  I've got a bunch of Virtex stuff that falls into that
> category.  Those who are interested can pick the non mainlined patches
> out of my git tree.

Ok. I'm fine either way.

Here we go. For anyone interested in the GPIOs on PowerPC, you
can keep an eye on this git tree:

	git://git.infradead.org/users/cbou/powerpc-gpio.git

As time will permit, I'll start gpiolib work in the "gpiolib"
branch in that repo, which will include gpiolib -mm patches +
powerpc bits.

Note: I'm quite often rebasing my work, be aware. ;-)


Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
