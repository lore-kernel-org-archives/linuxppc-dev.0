Date: Wed, 26 Sep 2001 15:43:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
Message-ID: <20010926154320.G13535@cpe-24-221-152-185.az.sprintbbd.net>
References: <35C119252057D511BB9F0003476BF8A208E5C3@freexc01.smartm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E5C3@freexc01.smartm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 26, 2001 at 09:40:31AM -0700, Prasad, Siva wrote:

> PowerPC 750 on a custom board.
> I tried both the bitkeeper source (2.4.10-pre11) and also HartHat Linux CDK
> 1.2 version (kernel 2.2.14). Same problem in both the kernels.

Well, both of those sources are very different.  Are you running this
board in 'PReP' mode?  Your own firmware or what?  Anyhow, if you're making
any calls back to the firmware later on, you must not mess w/ the MSR value.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
