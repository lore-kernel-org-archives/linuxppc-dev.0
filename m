Date: Fri, 26 Oct 2001 09:30:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Matt Porter <mmporter@home.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Lots of changes to PReP booting
Message-ID: <20011026093056.F6439@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011026050620.A14881@cx258813-a.chnd1.az.home.com> <Pine.LNX.4.33.0110261803030.17456-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0110261803030.17456-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 26, 2001 at 06:08:28PM +0200, Gabriel Paubert wrote:
>
>
> On Fri, 26 Oct 2001, Matt Porter wrote:
>
> >
> > On Thu, Oct 25, 2001 at 05:59:15PM -0700, Tom Rini wrote:
> > >
> > > Hey all.  Can people _please_ go and test this (disk and net if
> > > possible) and tell me if their machine still works?  The following
> > > changes have been made:
> > > 1) On 'znetboot' and 'znetboot.initrd', no longer give mkprep the -pbp
> > > option.  This allows my PowerStack (PPCBUG) to netboot successfully.
> > > This _hopefully_ won't break anyone else tho.
> >
> > Why?  You wanted to netboot from PPCBUG with PReP Network Boot disabled?
> > My PowerStack's have been booting fine with the -pbp'ed image (one
> > with the PReP header intact).  We've been doing it this way for years
> > now.
>
> Exactly.
[snip]

Okay.  I'm talking to Matt privately now, and this might have to do with
my old (1.5) version of PPCBUG, which doesn't seem to have this option.
So for now, forget about that part of the patch.  Can people please go
and test the rest of it tho?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
