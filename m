From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linuxppc-commit@fsmlabs.com>
Subject: Re: bi_records and cmd_line
Date: Sun, 11 Mar 2001 21:12:00 +0100
Message-Id: <20010311201200.25426@smtp.wanadoo.fr>
In-Reply-To: <20010311121049.A24589@opus.bloom.county>
References: <20010311121049.A24589@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hey all.  I'm working on getting all of the in-kernel "bootloaders" to use
>the bi_records struct for cmd_line.  I've got a question tho about xcoff
>(oldworld and newworld or no?).  Right now arch/ppc/kernel/setup.c has a
>comment in identify_machine about if we're xcoff, grab the cmd line from
>/chosen/bootargs.  Shouldn't this belong in coffboot.c instead? (Or,
chrmain.c
>as well?).

Tup. I beleive it's here for historical reasons.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
