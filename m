Date: Wed, 20 Nov 2002 08:23:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel, rc1 and rc2 problem.
Message-ID: <20021120152302.GI779@opus.bloom.county>
References: <20021119190116.13369.qmail@web20104.mail.yahoo.com> <IGEFJKJNHJDCBKALBJLLKECJFIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKECJFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 20, 2002 at 12:55:01PM +0100, Joakim Tjernlund wrote:
>

> I upgraded my linuxppc_2_4_devel from pre8(1.1130) to rc1(1.1157) and noticed that
> may syslog had problems to start:
>
[snip]

> I then tried rc2(BK curr) and got the same problem. I am running a custom mpc860 board.
>
> Anyone else noticed this?

I haven't tried yet.  Have you tried 'porting' your custom board to
vanilla 2.4.x, which would make it easier to see which, if any of these
upsteram revisions introduced a problem?  The only 8xx-specific changes
in that time have been your i2c changes and a serial fixup.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
