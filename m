Date: Mon, 24 Mar 2003 10:19:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: ppc: Makefile tidy-up round 2
Message-ID: <20030324171909.GA13300@ip68-0-152-218.tc.ph.cox.net>
References: <20030320222759.GA12267@mars.ravnborg.org> <20030322215403.GA15911@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030322215403.GA15911@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 22, 2003 at 10:54:03PM +0100, Sam Ravnborg wrote:
> More Makefile tidy-up - made on top of previous patches.
>
> 1) fixed a few bugs introduced when cleaning up boot/prep/Makefile
> 2) cleaned up boot/openfirmware/makefile
> 3) Got rid of boot/common/dummy.c
> 	It is now located in three copies but thats OK for a three line file
> See cset comments below.
>
> I have skipped "simple" clean up for now. Is it worth the effort?

Well, it's the most used, and has some other bits which need to be
cleaned up.  So, yes please.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
