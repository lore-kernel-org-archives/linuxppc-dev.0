Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (unknown [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 7D557B7B73
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 08:01:57 +1000 (EST)
Date: Sat, 26 Sep 2009 00:01:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
Message-ID: <20090925220151.GA3549@merkur.ravnborg.org>
References: <4ABB57CB.3000409@ru.mvista.com>
	<20090925194557.GA3323@merkur.ravnborg.org>
	<1253915852.7103.531.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253915852.7103.531.camel@pasglop>
Cc: rep.dot.nop@gmail.com, Yuri Frolov <yfrolov@ru.mvista.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 26, 2009 at 07:57:32AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2009-09-25 at 21:45 +0200, Sam Ravnborg wrote:
> > On Thu, Sep 24, 2009 at 03:28:11PM +0400, Yuri Frolov wrote:
> > > Hello,
> > > 
> > > here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
> > > This patch should correctly export crtsavres.o in order to make O= option working.
> > > Please, consider to apply.
> > 
> > Hi Yuri.
> > 
> > I like the way you do the extra link in Makefile.modpost.
> > But you need to redo some parts as per comments below.
> 
> > > 
> > > Fix linking modules against crtsavres.o
> > 
> > Please elaborate more on what this commit does.
> 
> It's a support file that needs to be linked against every module
> (aka libgcc like) and thus needs to be built before any module.

Yes.

My point was that the next version of the changelog should
include this information - as well as kbuild.txt.

	Sam
