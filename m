Date: Thu, 20 Sep 2001 08:58:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Salisbury <mbs@mc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
Message-ID: <20010920085825.F13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BAA0E6F.5050503@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BAA0E6F.5050503@mc.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 11:42:39AM -0400, Mark Salisbury wrote:

> question 1.  are there already existing patch sets (rejected from
> mainline inclusion) available for use as a starting point?

There was a bit of work, just for the kernel.  Nothing on the toolchain
side.

> question 2.  if 1, what is the primary reason for rejection.

Being a LE & BE arch becomes a giant PITA for no gain.

> question 3.  is there a general issue of endian safety in linux (I would
> think not) or just in the ppc-specific code?

In theory the generic code is endian safe, by and large.  The arch/ppc and
include/asm-ppc stuff assumes BE.

> question 4. assuming I was willing to deliver a clean, complete LE
> enabling patch (including devices that are relevant to me), as a compile
> time config option and maintain that patch, what would be the primary
> obstacle to inclusion in the main line.

The objection to being an arch that attempts to support both LE and BE.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
