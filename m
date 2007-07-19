Return-Path: <mgreer@mvista.com>
Date: Thu, 19 Jul 2007 08:58:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Do we need to reset the master branch?
Message-ID: <20070719155826.GB21186@mag.az.mvista.com>
References: <20070719151746.GB20538@mag.az.mvista.com>
	<20070720012708.91c77527.sfr@canb.auug.org.au>
	<20070719153217.GC20538@mag.az.mvista.com>
	<20070720014432.a46164a8.sfr@canb.auug.org.au>
	<20070720014618.a6eec3eb.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070720014618.a6eec3eb.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2007 at 01:46:18AM +1000, Stephen Rothwell wrote:
> On Fri, 20 Jul 2007 01:44:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > git remote add powerpc git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> > git fetch powerpc
> > 
> > This will track the tree in branches called powerpc/<branch> and do
> > resets as necessary.
> 
> You should not make any local commits to the powerpc/* branches, of course.

Right.
