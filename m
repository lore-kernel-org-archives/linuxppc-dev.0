Date: Mon, 17 Mar 2003 06:02:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Guenther SOMMER <gue@rettung.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc on dsp-board
Message-ID: <20030317130201.GA23106@ip68-0-152-218.tc.ph.cox.net>
References: <3E725ACA.7080301@rettung.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E725ACA.7080301@rettung.at>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 14, 2003 at 11:42:18PM +0100, Guenther SOMMER wrote:

> it's a dsp-board with some dsp on board an a motorola 860 processor. the
> board itself has 32mb sdram and 8 mb flash. the board has a bootloader
> integrated, which configures the mpcs and start a simple "boot-aplication".

It sounds like you would want the code inside of arch/ppc/boot/, with a
more or less empty 'embed_config' function.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
