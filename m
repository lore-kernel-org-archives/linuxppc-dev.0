Date: Mon, 10 Feb 2003 16:24:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] vs. latest linuxppc_2_4_devel fixes walnut build
Message-ID: <20030210232416.GC21429@ip68-0-152-218.tc.ph.cox.net>
References: <20030210191600.GA11296@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030210191600.GA11296@host109.fsmlabs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 10, 2003 at 12:16:00PM -0700, Cort Dougan wrote:

> This fixes 'make znetboot' for the walnut and ebony.  There are many files
> in arch/ppc/boot/images/ and the * in the cp command didn't work.

I think the 'correct' fix (for Walnut anyhow) is to set ZNETBOOT in the
CONFIG_IBM_OPENBIOS test.

But, could I talk you into letting the 'znetboot' / 'znetboot.initrd'
commands die?  Personally I've been using dd after a 'zImage' /
'zImage.initrd'.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
