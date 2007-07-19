Return-Path: <michal.k.k.piotrowski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id 1D2ABDDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 05:18:45 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so573824nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:18:44 -0700 (PDT)
Message-ID: <6bffcb0e0707191218j7ecc0fa4re2a2ae7c82c95668@mail.gmail.com>
Date: Thu, 19 Jul 2007 21:18:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
In-Reply-To: <200707192127.07238.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
	<200707192127.07238.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 19/07/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On Thursday 19 July 2007, Michal Piotrowski wrote:
>
> > IDE
> >
> > Subject         : compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
> > References      : http://lkml.org/lkml/2007/7/18/11
> > Last known good : ?
> > Submitter       : Kumar Gala <galak@kernel.crashing.org>
> > Caused-By       : ?
> > Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Status          : unknown
>
> Not a 2.6.22-git regression (CONFIG_BLOCK was added on September 2006) and
> Kumar should have a fix really soon - could be removed from the list IMO.

Ok, I removed it.

>
> Thanks,
> Bart
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
