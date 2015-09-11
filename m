Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24B381A0066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 12:13:57 +1000 (AEST)
Message-ID: <1441937624.2909.42.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add support for Varisys Cyrus board
From: Scott Wood <scottwood@freescale.com>
To: Andy Fleming <afleming@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Kumar
 Gala" <galak@kernel.crashing.org>, Alex Perez <aperez@alexperez.com>
Date: Thu, 10 Sep 2015 21:13:44 -0500
In-Reply-To: <CAKWjMd4YqAA1f0QzGxT1Hr+e_ceft2RHEUH649R5cfZ293t4eQ@mail.gmail.com>
References: <1441175814-14940-1-git-send-email-afleming@gmail.com>
 <1441217278-21618-1-git-send-email-afleming@gmail.com>
 <CAKWjMd45zYZefWWxsdOO2BE2CYOTpdbXzXz6caN9Sr8XUF6PgA@mail.gmail.com>
 <1441936384.2909.29.camel@freescale.com>
 <CAKWjMd4YqAA1f0QzGxT1Hr+e_ceft2RHEUH649R5cfZ293t4eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-10 at 21:06 -0500, Andy Fleming wrote:
> On Thu, Sep 10, 2015 at 8:53 PM, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, 2015-09-10 at 20:51 -0500, Andy Fleming wrote:
> > > ping? I'd love if this could go in for 4.3
> > 
> > It's way too late for 4.3.
> > 
> > -Scott
> 
> Argh. I was hoping that, as it's a one-line change to existing code it
> might be able to sneak in.

It's hard to call it "sneaking in" when a new pull request chain has to be 
created just for one patch. :-P

Non-bugfixes need to be in my pull request to Michael before the merge window 
opens (and thus submitted long enough before that for me to have a chance to 
do a review/apply/build-test session), not a couple days before the merge 
window closes.  Why does it matter if this is in 4.3 versus 4.4?

-Scott
