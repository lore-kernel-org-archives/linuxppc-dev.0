Date: Thu, 8 Nov 2001 14:47:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20011108144704.B2271@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011108193006.26A0010028@hostme.bitkeeper.com> <20011108123809.C1700@cpe-24-221-152-185.az.sprintbbd.net> <3BEAFBCE.5000702@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BEAFBCE.5000702@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 08, 2001 at 04:40:30PM -0500, Dan Malek wrote:
> Tom Rini wrote:
>
>
> >I was thinking about this a bit.  The problem is that we have multiple
> >types of serial controllers we need to 'init' some how.
>
> This is because I tried to use the same functions across a wide variety
> of boards.  All we need to do is define a macro in a board specific
> file someplace that calls the proper init function.

Yes, but then you end up with lots and lots of files with just a few
lines, or:
#if defined(A) || defined(B) || defined(C) || ... || defined(W)
#define serial_init(a) foo_init(a)
#endif

#if defined(X) || defined(Y) || ... || defined(Z)
#define serial_init(a) bar_init(a)
#endif

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
