Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E6FCC1400A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 07:15:47 +1000 (EST)
Message-ID: <1399670133.15726.440.camel@snotra.buserror.net>
Subject: linux-next: add scottwood/linux.git
From: Scott Wood <scottwood@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 9 May 2014 16:15:33 -0500
In-Reply-To: <1395709794.12479.411.camel@snotra.buserror.net>
References: <20140320042527.GA23206@home.buserror.net>
 <1395616617.3460.109.camel@pasglop> <1395617608.3460.113.camel@pasglop>
 <1395709794.12479.411.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-24 at 20:09 -0500, Scott Wood wrote:
> On Mon, 2014-03-24 at 10:33 +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-03-24 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2014-03-19 at 23:25 -0500, Scott Wood wrote:
> > > > The following changes since commit c7e64b9ce04aa2e3fad7396d92b5cb92056d16ac:
> > > > 
> > > >   powerpc/powernv Platform dump interface (2014-03-07 16:19:10 +1100)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> > > > 
> > > > for you to fetch changes up to 48b16180d0d91324e5d2423c6d53d97bbe3dcc14:
> > > > 
> > > >   fsl/pci: The new pci suspend/resume implementation (2014-03-19 22:37:44 -0500)
> > > 
> > > Stephen just informed me that your tree wasn't in -next ... Kumar's
> > > still is.
> > > 
> > > Can you guys fix that up ? I somewhat rely on the FSL stuff to simmer
> > > in -next on its own.
> 
> Stephen, what's the process for adding a tree?

ping

-Scott


> 
> I suppose we should update MAINTAINERS while we're at it.
> 
> > Oh and where is my little summary to put in the merge commit ?
> > 
> > I made one up for this time around.
> 
> Oops, forgot again.  Now I've added something to the script I use to
> generate pull requests, to give me a reminder.
> 
> -Scott
> 
