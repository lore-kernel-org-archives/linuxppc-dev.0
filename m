Date: Wed, 6 Mar 2002 14:15:00 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
Message-ID: <20020306141500.B2739@ecam.san.rr.com>
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu> <3C7D0AB9.5070801@pacbell.net> <20020304131703.A15551@ecam.san.rr.com> <3C838533.6050603@pacbell.net> <20020304195328.B15551@ecam.san.rr.com> <3C84A33A.30700@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C84A33A.30700@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 05, 2002 at 10:51:38AM +0000, Armin wrote:
>
> andrew may wrote:
>
> >
> > Well I just noticed that building as a module is pretty far from
> > working at the moment. Are there any plans to fix this?
>
> Havn't thought about it but sound like it needs to addressed.
>
> > I am not
> > sure how to cleanly get this working since there are all sorts of
> > exports/externs that need to be fixed up.
>
> I can add it to my TODO list unless you need it asap?

No there is no rush getting this working as a module. I would like
a nice way to set the amount to reserve on the skb dynamically
though.

> > I
> > don't know if we want to do this for the ocp_enet as well.
> >
> fine with me.

So would it be easier to just ask someone with bk access to the
tree to add the dir and move the files rather than do a patch.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
