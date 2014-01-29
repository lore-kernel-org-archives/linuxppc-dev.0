Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54CB12C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 21:11:37 +1100 (EST)
Date: Wed, 29 Jan 2014 11:11:25 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Please pull 'next' branch of 5xxx tree
Message-ID: <20140129101125.GJ20094@book.gsilab.sittig.org>
References: <20140115221859.50866e87@crub> <20140128064614.511d36be@crub>
 <1390888814.8524.13.camel@pasglop>
 <1390981569.8524.53.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390981569.8524.53.camel@pasglop>
Cc: Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 29, 2014 at 18:46 +1100, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2014-01-28 at 17:00 +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2014-01-28 at 06:46 +0100, Anatolij Gustschin wrote:
> > > Hi Ben !
> > > 
> > > On Wed, 15 Jan 2014 22:18:59 +0100
> > > Anatolij Gustschin <agust@denx.de> wrote:
> > > 
> > > > Hi Ben !
> > > > 
> > > > please pull mpc5xxx patches for v3.14:
> > > 
> > > Ping.
> > 
> > Oops, you sent that while I was on vacation and I missed it.
> > 
> > Next time, try to send your pull request earlier if possible, I'd like
> > to have most stuff together before -rc5. I'll try to send this one to
> > Linus after he has pulled my current one.
> 
> Hrm, I get a merge conflicts with spi-mpc512x-psc.c, please check that I
> fixed it up properly in powerpc-next and let me know.

Did read the merge commit (git show e9a371100dfd), did a build
and run test of

  f878f84373ae powerpc: Wire up sched_setattr and sched_getattr syscalls

and everything looks good.  Thank you!


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
