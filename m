Date: Tue, 18 Sep 2001 11:57:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net>
References: <EFEAIMDCOOOHIEPHDNFJEEENDCAA.stefan.roese@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFEAIMDCOOOHIEPHDNFJEEENDCAA.stefan.roese@esd-electronics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 10, 2001 at 06:36:47PM +0200, Stefan Roese wrote:

> Please find attached a port to our CPCI-405 board (a CompactPCI board based
> on the IBM PPC405GP). This  patch is based upon "Linux-2.4.10-pre6" from the
> linuxppc_2_4_devel tree a few hour ago.

This looks good, but I've got some minor questions.  First, does
arch/ppc/kernel/cpci405.c need all of those includes?  (And is bios_fixup
an init time only function?)  Also do we actually need
include/asm-ppc/cpci405.h?  All it does is include ppcboot.h.  So I'm
guessing this board only boots w/ PPCBOOT, which should include it's own
version of this file.  So is this really needed?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
