Date: Fri, 21 Dec 2001 09:53:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: time patch.
Message-ID: <20011221165336.GU763@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C2366B0.70508@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C2366B0.70508@cray.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 21, 2001 at 10:43:28AM -0600, David Updegraff wrote:

> If Could someone with write acces to the tree could patch
> 	arch/ppc/kernel/time.c
> so that for cases where we have no RTC?  On our non-nvram,
> non-RTC board, running NTP falls into this [un-suprising] kernel panic.

Can you post this as a proper patch?  (unified is prefered).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
