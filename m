Date: Mon, 9 Aug 2004 10:28:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	David Woodhouse <dwmw2@infradead.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
Message-ID: <20040809132828.GC5733@logos.cnet>
References: <20040726044034.GA16491@gate.ebshome.net> <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 26, 2004 at 09:48:47PM +0800, Song Sam wrote:
>
> --- Eugene Surovegin <ebs@ebshome.net> wrote£º
>
> > On Mon, Jul 26, 2004 at 12:13:17AM -0400, David
> > Woodhouse wrote:
> > >
> > > On Mon, 26 Jul 2004, [gb2312] Song Sam wrote:
> > > > But 2.4 kernel is still a pet for 8xx,at least. I guess many
> > > > embedded Linux development lean to 2.4 kernel for the moment.For
> > > > Linux kernel hackers,2.4 kernel was dead but it is alive for most
> > > > embedded developers.Right? :-)
> > >
> > > I cannot speak for 'most embedded developers.'; only those with
> > > clue.
>
> Sorry,I got you wrong.I was a little too sensitive to
> see 2.4 with "dead".Just gave my opinion on 2.4 kernel
> on embedded development.
>
> > > I would not consider deploying anything new on 2.4 today; it's just
> > > not a viable, maintainable platform in my opinion.
>
> It was really a puzzle for me why 2.4 is NOT a viable,
> maintainable platform but it is used more than 2.6.x
> in many embedded development.Also why to see 2.4 dying
> without leaving the official maintaining work to some
> volunteers? Any special reason?

I think what David means is that v2.6 is the new platform
where all development effort is being done. Most of its core
code, in general, is much cleaner than v2.4.

I disagree with him when he says "v2.4 is dead" (I coudlnt otherwise :)),
because its still maintained and will be for years. And its still in
use by a lot of folks.

But his point is that new development efforts should be based on the
new, shiny, improved v2.6 kernel, since that is where all development
is focused at. And as time passes, v2.4 will get more and more
obsolete.

Unfortunately for 8xx users, as noted by other people on this thread,
v2.6 is not yet 100% (wish it was, I'm myself trying to get our boards
to boot v2.6).

There are some TLB related issue which needs fixing, Panto got a workaround
which works for him (while not being fully optimal). Dan Malek and Panto, at
least, know exactly what still needs work (unlike me).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
