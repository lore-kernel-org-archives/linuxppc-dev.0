From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: dcbz-instruction on PPC405GP
Date: Mon, 14 Jul 2003 09:09:13 +0200
References: <200307111623.45470.jbeisert@eurodsn.de> <20030711163123.GY17433@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030711163123.GY17433@ip68-0-152-218.tc.ph.cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307140909.13308.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Am Freitag, 11. Juli 2003 18:31 schrieb Tom Rini:
> On Fri, Jul 11, 2003 at 04:23:45PM +0200, Juergen Beisert wrote:
>
> Why are you not calling memset on this region instead?

"memset" only uses simple store instructions. But besides the "memset"
function if found "cacheable_memzero". Seems in my own code is a bug, because
"cacheable_memzero" runs with "dcbz" on my data buffer without an error.

Thanks for your suggestion
-- JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
