Date: Fri, 26 Oct 2001 18:08:28 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Lots of changes to PReP booting
In-Reply-To: <20011026050620.A14881@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.LNX.4.33.0110261803030.17456-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 26 Oct 2001, Matt Porter wrote:

>
> On Thu, Oct 25, 2001 at 05:59:15PM -0700, Tom Rini wrote:
> >
> > Hey all.  Can people _please_ go and test this (disk and net if
> > possible) and tell me if their machine still works?  The following
> > changes have been made:
> > 1) On 'znetboot' and 'znetboot.initrd', no longer give mkprep the -pbp
> > option.  This allows my PowerStack (PPCBUG) to netboot successfully.
> > This _hopefully_ won't break anyone else tho.
>
> Why?  You wanted to netboot from PPCBUG with PReP Network Boot disabled?
> My PowerStack's have been booting fine with the -pbp'ed image (one
> with the PReP header intact).  We've been doing it this way for years
> now.

Exactly. And sorry if I've misssed earlier discussions, I just discovered
this morning that I had been disconnected from linuxppc-dev for at least 3
weeks, perhaps more (probably at the time our computer staff upgraded the
mail server and all mail was explicitly refused for 2 days, strangely
linuxppc-commit did not expel me). I' too busy on other fronts now to
catch up rading the archives....


This said, i should try one day to upgrade my bootloader for 2.4.xx, after
all, AFAICT no other bootloader includes an x86 BIOS ROM emulator.
The code is still on vlab1.iram.es or people who want to play with it but
it is broken since 2.2.17 or so (I succeeded in booting 2.4.0, however).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
