Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 82A4767B83
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 19:15:37 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2911000ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Dec 2006 00:15:35 -0800 (PST)
Message-ID: <528646bc0612050015xa18b33bh4afdc2f9d196f1a1@mail.gmail.com>
Date: Tue, 5 Dec 2006 01:15:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: master branch reset
In-Reply-To: <Pine.LNX.4.62.0612050901160.12448@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <17780.2568.641734.276805@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0612050839120.12448@pademelon.sonytel.be>
	<528646bc0612042349t34662037nc641c8e6e2516a09@mail.gmail.com>
	<Pine.LNX.4.62.0612050901160.12448@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/5/06, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> On Tue, 5 Dec 2006, Grant Likely wrote:
> > On 12/5/06, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > On Mon, 4 Dec 2006, Paul Mackerras wrote:
> >
> > > Any clues? Delete and reclone?
> >
> > Because Paul had to redo his tree; you're no longer able to 'pull' his
> > changes into your branch.  If you've got changes that you need to
> > preserve; then you need to either generate a diff between Paul's old
> > HEAD and your HEAD; then apply that to a new branch based of Paul's
> > new HEAD.
> >
> > Or; you can create a new branch based on the new HEAD and
> > 'git-cherry-pick' your changes into it.
> >
> > Either way, it can be rather painful.
>
> I didn't make any local changes, so I assumed I could just follow Paul's
> instructions. But they failed.

You're in easy street then; assuming you just cloned from powerpc.git, just do:

git-reset --hard origin

and your done.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
