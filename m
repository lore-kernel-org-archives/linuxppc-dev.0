Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9379CDDF51
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 07:04:03 +1100 (EST)
Date: Tue, 8 Jan 2008 23:13:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Hwmon for Taco
Message-ID: <20080108201314.GA29127@localhost.localdomain>
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
	<47831868.3030309@pikatech.com>
	<fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
	<4783C128.8050103@pikatech.com>
	<20080108130251.7ae351c7@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080108130251.7ae351c7@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 01:02:51PM -0600, Josh Boyer wrote:
> On Tue, 08 Jan 2008 13:30:00 -0500
> Sean MacLennan <smaclennan@pikatech.com> wrote:
> 
> > Ok, here is the ad7414 only. taco-dtm is no more!
> 
> Cool.  Couple more things.
> 
> 1) This should go through the hwmon maintainer.  Send it to him.
> (CC'ing this list is of course fine.)
> 
> 2) You always need the Signed-off-by: for each patch you send
> 
> 3) If you didn't author the code (this seems to come from Stefan), then
> you need the Signed-off-by from the original author.

Nope. Signed-off-by means completely different thing. It isn't
copyright, it isn't authorship. It's an information (for the history)
whom to bother if code appeared to be either:
a) broken;
b) stolen from the closed source product;
c) patented (where applicable).

There are Copyright (c) and Author: strings in the files for the
credits. If original patch had these strings, then yes, you must
keep them.

But no one needs author's Signed-off-by, it having zero information
you're hinting about. More than that, there were precedents when
author insisted on removing his Signed-off-by from the modified
patch (when S-o-b used as a permit into someone's tree).

Btw, kernel.org is distributing linux tarballs without changelogs,
thus without Signed-off-by lines. Nobody complains.


Yes, it's common sense and politeness to keep Signed-off-by lines
intact (and the order of these lines), but it's not strict
requirement. "Based on the patch from ..." is the equivalent of
this politeness.

> You're getting there :)  These are all "newbie" type mistakes so keep
> plugging away.
> 
> josh

Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
