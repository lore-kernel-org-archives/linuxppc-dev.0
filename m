Date: Fri, 31 May 2002 07:51:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sergiy Kovtun <skovtun@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
Message-ID: <20020531145120.GI32412@opus.bloom.county>
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020531060244.15732.qmail@web11204.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:

> Hello All,
> I try to connect all my 64 Meg memoty on
> Sandpoint-X3B,
> but received a crash( with 32M all OK).
> Source:
> SP-X3B + Altimus MPC7410
> HHL 2.0
> Any ideas??

DINK32 12.2 does not correctly initalize the memory controller on-board.
DINK32 12.3 claims to do this correctly, but in some testing locally it
still did not get everything correct.

There's a chance that PPCBoot does get this right, however.  But I'm no
PPCBoot expert.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
