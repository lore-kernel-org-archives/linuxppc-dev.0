Date: Sun, 11 Mar 2001 12:10:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: bi_records and cmd_line
Message-ID: <20010311121049.A24589@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  I'm working on getting all of the in-kernel "bootloaders" to use
the bi_records struct for cmd_line.  I've got a question tho about xcoff
(oldworld and newworld or no?).  Right now arch/ppc/kernel/setup.c has a
comment in identify_machine about if we're xcoff, grab the cmd line from
/chosen/bootargs.  Shouldn't this belong in coffboot.c instead? (Or, chrmain.c
as well?).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
