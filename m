Date: Wed, 28 Nov 2001 16:36:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dan Malek <dan@embeddededge.com>,
	Alex Zeffertt <ajz@cambridgebroadband.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx parameter RAM clashes
Message-ID: <20011128163637.B29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C2CAA01.6040801@embeddededge.com> <20011128173513.92695F9BB@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011128173513.92695F9BB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 06:35:08PM +0100, Wolfgang Denk wrote:
>
> In message <3C2CAA01.6040801@embeddededge.com> you wrote:
> >
> > > it would be nice if the drivers would  register  the  locations  they
> > > use,  and  actually  CHECK for collisions, instead of silently let us
> > > run into strange and often hard to debug error conditions.
> >
> > So, add it then.
>
> Does that mean that such a patch would be accepted?

Yes.  And if you want to throw in more error checking/handling, please
do.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
