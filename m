Date: Thu, 22 Aug 2002 09:36:19 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: John Fisher <John.Fisher@nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux
In-Reply-To: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Message-ID: <Pine.LNX.4.40.0208220914420.2118-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Aug 2002, John Fisher wrote:

> > Actually, my personal opinion on that matter is that I'm not very fond
> > of using Windows for a Linux kernel development platform. Doing --
>
> So what are the issues: How is cygwin significantly different from Linux
> that you would not want to use it?

My advise against compiling a kernel and generating boot images (ie.
integrating the parts of an embedded Linux project) is on two grounds:

1. You will only succeed in doing so by emulating a lot of aspects of a
   regular Linux build machine. That's why you need something like Cygwin.
   On that way you are loosing some of Windows's advantages (YMMV), most
   notably and of the GUI features. What you end up with is more or less
   like any Linux terminal, so you might as well do the job on a real
   Windows box that you log on to from your Windows machine, if you must.

2. The "emulation" will never be 100%. Maybe 99%. Maybe 99.99%. That last
   fraction can be a major PITA, because it is not obvious. To compile a
   kernel you need a lot of tools with a lot of explicit and implicit twists
   to them. It is just a gut feeling that I wouldn't want to rely on this,
   if I don't have to. The native way just seems the better way to do it to
   me.

> Are there useful tools that run under Linux but not under cygwin?

Probably you can get pretty many tools for Cygwin too. But it may not be as
easy.

But please don't get me wrong: my point isn't religious: there are
situations where you simply have to use what you're given (at least if
you want to keep your job :-), and Cygwin definitely is a valid
alternative. I'd just not go through this trouble if I don't really
have to.

> The reason I ask is that my organization currently does its software
> development under windows using proprietary tools. We have to maintain our
> existing products using these tools. We are however contemplating new
> development using linux. If we have to dual boot our PCs or have an extra PC
> running Linux for each developer, that is going to bring its own set of
> nuisances and problems.

Well, if you're really jumping ship with the new projects, you should go the
full way and install Linux workstations. You'll have to in the long run. You
could try VMware for the maintainance business. We're using VMware here
quite successfully.

Regards
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
