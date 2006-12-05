Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 069BC679E9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 20:23:38 +1100 (EST)
Date: Tue, 5 Dec 2006 10:23:37 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: master branch reset
In-Reply-To: <528646bc0612050015xa18b33bh4afdc2f9d196f1a1@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0612051022470.20543@pademelon.sonytel.be>
References: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0612050839120.12448@pademelon.sonytel.be>
	<528646bc0612042349t34662037nc641c8e6e2516a09@mail.gmail.com>
	<Pine.LNX.4.62.0612050901160.12448@pademelon.sonytel.be>
	<528646bc0612050015xa18b33bh4afdc2f9d196f1a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 5 Dec 2006, Grant Likely wrote:
> On 12/5/06, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > On Tue, 5 Dec 2006, Grant Likely wrote:
> > > On 12/5/06, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > > On Mon, 4 Dec 2006, Paul Mackerras wrote:
> > >
> > > > Any clues? Delete and reclone?
> > >
> > > Because Paul had to redo his tree; you're no longer able to 'pull' his
> > > changes into your branch.  If you've got changes that you need to
> > > preserve; then you need to either generate a diff between Paul's old
> > > HEAD and your HEAD; then apply that to a new branch based of Paul's
> > > new HEAD.
> > >
> > > Or; you can create a new branch based on the new HEAD and
> > > 'git-cherry-pick' your changes into it.
> > >
> > > Either way, it can be rather painful.
> > 
> > I didn't make any local changes, so I assumed I could just follow Paul's
> > instructions. But they failed.
> 
> You're in easy street then; assuming you just cloned from powerpc.git, just
> do:
> 
> git-reset --hard origin
> 
> and your done.

Apparently not :-(

| pademelon$ git-reset --hard origin
| pademelon$ git pull -v
| Unpacking 10843 objects
|  100% (10843/10843) done
| * committish: ef6a3165e75c189da82c943a081cd1da52068738
|   branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/for-2.6.20: same as branch 'for-2.6.20' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * committish: e62438630ca37539c8cc1553710bbfaa3cf960a7
|   branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
| * refs/heads/origin: does not fast forward to branch 'master' of git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
|   not updating.
| pademelon$

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
