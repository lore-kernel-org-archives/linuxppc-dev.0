Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 26 Jul 2004 10:27:52 -0400 (EDT)
From: David Woodhouse <dwmw2@infradead.org>
To: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
In-Reply-To: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
Message-ID: <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 26 Jul 2004, [gb2312] Song Sam wrote:

> Sorry,I got you wrong.I was a little too sensitive to
> see 2.4 with "dead".Just gave my opinion on 2.4 kernel
> on embedded development.

Deployment if you're already almost ready to ship is sane enough, I
suppose -- but to actually put more effort into 2.4 wouldn't make much
sense.

> It was really a puzzle for me why 2.4 is NOT a viable,
> maintainable platform but it is used more than 2.6.x
> in many embedded development.Also why to see 2.4 dying
> without leaving the official maintaining work to some
> volunteers? Any special reason?

Because nobody's really that interested in it. For what it's worth, I've
abandoned all pretence of continuing to support 2.4 in the MTD/JFFS2 CVS
tree. I won't object too hard if someone else wants to fix it up, _if_
that doesn't uglify the 2.6 code.

If 2.4 works already for you, by all means use it -- but if you're doing
any new development, or you _really_ want people to care when you find
bugs, it really ought to be 2.6.

> > I would not consider deploying anything on 2.6
> > today. IMHO it's not mature
> > enough to be used in production environment.
>
> I do agree with the view.I guess it is most embedded
> developers's opinion.

Out of interest, how many platforms are you using 2.6 on and how does
your experience with these platforms support your stated view?

--
dwmw2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
