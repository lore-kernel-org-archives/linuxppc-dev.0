From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15607.39471.62466.849679@gargle.gargle.HOWL>
Date: Fri, 31 May 2002 10:43:43 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sergiy Kovtun <skovtun@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
In-Reply-To: <20020531152615.GO32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
	<20020531145120.GI32412@opus.bloom.county>
	<15607.36947.107412.219533@gargle.gargle.HOWL>
	<20020531151130.GN32412@opus.bloom.county>
	<15607.38056.877088.211807@gargle.gargle.HOWL>
	<20020531152615.GO32412@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini writes:

> > A sandpoint (esp with Dink) is neither CHRP or PMAC, so the call to
> > FREESEC(openfirmware) shouldn't have occurred.
>
> It's !have_of, so we really did want to free the __openfirmware stuff.

OK, I get it.

--
"Perl is basically TECO-99."  ---Barry Shein


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
