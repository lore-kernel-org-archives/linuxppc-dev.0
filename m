Message-ID: <3CF7BE91.825324EE@mvista.com>
Date: Fri, 31 May 2002 14:18:57 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jim Thompson <jim@musenki.com>,
	Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com> <20020531145120.GI32412@opus.bloom.county> <15607.36947.107412.219533@gargle.gargle.HOWL> <20020531151130.GN32412@opus.bloom.county> <15607.38056.877088.211807@gargle.gargle.HOWL> <20020531152615.GO32412@opus.bloom.county> <3CF7B768.D2C20A4B@mvista.com> <20020531181349.GX32412@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> > I dunno guys, I think the compiler usually optimizes that all away and you
> > should never see "openfirmware".  I don't recall ever seeing it print out.  I
> > think something fishy is going on...
>
> Er, first, it becomes:
> if (1)
> So we always 'do it'.  However, all of the __openfirmware code is now
> almost never compiled in on !CONFIG_ALL_PPC, so we never see it being
> free'd.

That was my point.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
