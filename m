Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 5DB45DDEE4
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:44:36 +1000 (EST)
Date: Fri, 19 Oct 2007 17:44:35 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
Message-ID: <20071019154435.GA32172@powerlinux.fr>
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
	<20071019112916.GE27403@nd47.coderock.org>
	<fa686aa40710190609jebd4e31q9240d2ff5b4a5d47@mail.gmail.com>
	<20071019153528.GC31749@powerlinux.fr>
	<fa686aa40710190843l15d37ebdk71cd6b660aa1eab8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710190843l15d37ebdk71cd6b660aa1eab8@mail.gmail.com>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 09:43:38AM -0600, Grant Likely wrote:
> On 10/19/07, Sven Luther <sven@powerlinux.fr> wrote:
> > On Fri, Oct 19, 2007 at 07:09:16AM -0600, Grant Likely wrote:
> > > On 10/19/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > > On 17/10/07 10:36 -0600, Grant Likely wrote:
> > > > > From: Grant Likely <grant.likely@secretlab.ca>
> > > > >
> > > > > Only the MPC5200 needs this bug fix.  MPC5200B is okay.
> > > > >
> > > > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > > > ---
> > > > >
> > > > > Sven, Domen;
> > > > >
> > > > > Can you please test this patch?
> > > >
> > > > I found no obvious problems with it on Efika (mpc5200b)
> > >
> > > Cool, I'll add it to my list of patches for Paulus to pull
> >
> > Sorry, i have not had time to test, but there is a problem with the
> > userland serial console i want to investigate. At the latest i will test
> > this on monday.
> 
> Your userland serial problems are unrelated to this patch though, right?

Most definitively, sorry for the confusion.

Friendly,

Sven Luther
