Return-Path: <sam@ravnborg.org>
Received: from pqueuea.post.tele.dk (pqueuea.post.tele.dk [193.162.153.9])
	by ozlabs.org (Postfix) with ESMTP id 5E98FB7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 14:58:50 +1000 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 95D85DBEE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 06:39:12 +0200 (CEST)
Date: Fri, 25 Sep 2009 06:39:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
Message-ID: <20090925043902.GA2484@merkur.ravnborg.org>
References: <4ABB57CB.3000409@ru.mvista.com>
	<1253841141.7103.489.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253841141.7103.489.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
	Yuri Frolov <yfrolov@ru.mvista.com>, rep.dot.nop@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 25, 2009 at 11:12:21AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2009-09-24 at 15:28 +0400, Yuri Frolov wrote:
> > Hello,
> > 
> > here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
> > This patch should correctly export crtsavres.o in order to make O= option working.
> > Please, consider to apply.
> > 
> > 
> > Fix linking modules against crtsavres.o
> 
> Hi !
> 
> This is the same patch you already posted as "
> 
> 
> [PATCH] Fix linking modules against
> crtsavres.o
> "
> 
> Or it's an update ?
> 
> I've asked Sam to review it already since it affects the main kernel
> makefiles, waiting for his answer.
Saw the duplicates. Will get back to it tonight (morning here now).

	Sam
