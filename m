Date: Thu, 6 Sep 2001 11:42:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs vs gcc-2.95.x
Message-ID: <20010906114258.P21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010906112613.M21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906123022.D5873@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010906123022.D5873@ftsoj.fsmlabs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 12:30:22PM -0600, Cort Dougan wrote:

> Is this a comment by me?  If so, that was a problem with
> __builtin_return_address() not working in leaf functions which still exists
> today, I believe.  The "fix" there is a hack to leave those outline in lieu
> of the inline versions so that several functions were made non-leaf.

It's unclaimed.  The comment is:
/* alas, egcs sounds like it has a bug in this code that doesn't use the
   inline asm correctly, and can cause file corruption. Until I hear that
   it's fixed, I can live without the extra speed. I hope. */

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
