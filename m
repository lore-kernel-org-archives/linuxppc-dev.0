Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id C1473DDFAA
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:43:40 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so83211nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:43:39 -0700 (PDT)
Message-ID: <fa686aa40710190843l15d37ebdk71cd6b660aa1eab8@mail.gmail.com>
Date: Fri, 19 Oct 2007 09:43:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sven Luther" <sven@powerlinux.fr>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
In-Reply-To: <20071019153528.GC31749@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
	<20071019112916.GE27403@nd47.coderock.org>
	<fa686aa40710190609jebd4e31q9240d2ff5b4a5d47@mail.gmail.com>
	<20071019153528.GC31749@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Sven Luther <sven@powerlinux.fr> wrote:
> On Fri, Oct 19, 2007 at 07:09:16AM -0600, Grant Likely wrote:
> > On 10/19/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > On 17/10/07 10:36 -0600, Grant Likely wrote:
> > > > From: Grant Likely <grant.likely@secretlab.ca>
> > > >
> > > > Only the MPC5200 needs this bug fix.  MPC5200B is okay.
> > > >
> > > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > > ---
> > > >
> > > > Sven, Domen;
> > > >
> > > > Can you please test this patch?
> > >
> > > I found no obvious problems with it on Efika (mpc5200b)
> >
> > Cool, I'll add it to my list of patches for Paulus to pull
>
> Sorry, i have not had time to test, but there is a problem with the
> userland serial console i want to investigate. At the latest i will test
> this on monday.

Your userland serial problems are unrelated to this patch though, right?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
