Date: Mon, 9 Jul 2001 08:05:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How do I get the latest files off of bit keeper
Message-ID: <20010709080553.H825@opus.bloom.county>
References: <3B49BCDD.CD4632B7@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B49BCDD.CD4632B7@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 09, 2001 at 10:17:01AM -0400, Ralph Blach wrote:

> How do I get the latest tree of off bitkeeper to so that I can review
> and build the source tree?

After you get a copy of the tree, via bk clone, do a bk -r get -q to have
bk checkout all of the files.  Don't do bk -r edit, unless you really mean
to edit every file.  Do this on a per-file baisis.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
