Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsJj1mTnzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:50:13 +1000 (AEST)
Message-ID: <1467085812.32607.3.camel@ellerman.id.au>
Subject: Re: powerpc/fadump: trivial fix of spelling mistake, clean up message
From: Michael Ellerman <mpe@ellerman.id.au>
To: Colin Ian King <colin.king@canonical.com>, Joe Perches
 <joe@perches.com>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
 <akpm@linux-foundation.org>,  linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 28 Jun 2016 13:50:12 +1000
In-Reply-To: <57710F50.2070800@canonical.com>
References: <3rcf3g63Wnz9s5Q@ozlabs.org> <5771021E.3050305@canonical.com>
 <1467024695.1847.87.camel@perches.com>
 <1467026427.29808.4.camel@ellerman.id.au> <57710F50.2070800@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-27 at 12:34 +0100, Colin Ian King wrote:
> On 27/06/16 12:20, Michael Ellerman wrote:
> > On Mon, 2016-06-27 at 03:51 -0700, Joe Perches wrote:
> > > On Mon, 2016-06-27 at 11:38 +0100, Colin Ian King wrote:
> > > > On 26/06/16 05:19, Michael Ellerman wrote:
> > > > > On Fri, 2016-24-06 at 17:43:00 UTC, Colin King wrote:
> > > > > > trivial fix to spelling mistake "rgistration" and minor clean up
> > > > > > of the printk error message
> > > > > Can you also:
> > > > >  - use pr_err()
> > > > >  - unsplit the message, ie. keep the string all on one line.
> > > > I can unsplit the string, but checkpatch will complain about that, so
> > > > I'm not sure if that's preferred or not.
> > > > 
> > > > WARNING: line over 80 characters
> > > 
> > > If the statement is wrapped after the format,
> > > then checkpatch shouldn't complain.
> > > 
> > > 	pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n",
> > > 	       rc);
> > 
> > But that's not actually any more readable, so just ignore checkpatch in this
> > case IMHO. It's a guide, not the gospel.
>
> OK, so shall I'll send a V3 w/o the spit and the pr_err fix?

Nah that's fine, I already grabbed v2.

cheers
